[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$BaselineApk,
  [string]$CurrentApk,
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [int]$BootTimeoutSeconds = 300
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

function Get-UiXml([string]$Adb, [string]$TargetDevice) {
  $remote = '/sdcard/evefit_v112_upgrade_window.xml'
  & $Adb -s $TargetDevice shell rm -f $remote | Out-Null
  & $Adb -s $TargetDevice shell uiautomator dump $remote 2>$null | Out-Null
  if ($LASTEXITCODE -ne 0) { return $null }
  $text = (& $Adb -s $TargetDevice shell cat $remote) -join "`n"
  try { return ,([xml]$text) } catch { return $null }
}

function Wait-UiNode {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$Text,
    [string]$Class,
    [int]$TimeoutSeconds = 45
  )
  $deadline = [DateTime]::UtcNow.AddSeconds($TimeoutSeconds)
  do {
    $xml = Get-UiXml $Adb $TargetDevice
    if ($xml) {
      $node = @($xml.SelectNodes('//node')) | Where-Object {
        (-not $Text -or $_.text -eq $Text -or $_.'content-desc' -eq $Text -or $_.text -like "*$Text*" -or $_.'content-desc' -like "*$Text*") -and
        (-not $Class -or $_.class -eq $Class)
      } | Select-Object -First 1
      if ($node) { return $node }
    }
    Start-Sleep -Milliseconds 500
  } while ([DateTime]::UtcNow -lt $deadline)
  return $null
}

function Invoke-UiTap([string]$Adb, [string]$TargetDevice, $Node) {
  if ($Node.bounds -notmatch '^\[(\d+),(\d+)\]\[(\d+),(\d+)\]$') {
    throw "Invalid UI bounds: $($Node.bounds)"
  }
  $x = [int](([int]$matches[1] + [int]$matches[3]) / 2)
  $y = [int](([int]$matches[2] + [int]$matches[4]) / 2)
  & $Adb -s $TargetDevice shell input tap $x $y | Out-Null
}

function Find-And-TapWithScroll {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$Text,
    [int]$Attempts = 10
  )
  for ($attempt = 0; $attempt -lt $Attempts; $attempt++) {
    $node = Wait-UiNode $Adb $TargetDevice $Text '' 2
    if ($node) {
      Invoke-UiTap $Adb $TargetDevice $node
      return
    }
    & $Adb -s $TargetDevice shell input swipe 700 2200 700 700 300 | Out-Null
    Start-Sleep -Milliseconds 400
  }
  throw "UI item not found after scrolling: $Text"
}

function Save-Screenshot([string]$Adb, [string]$TargetDevice, [string]$Path) {
  $command = '"{0}" -s {1} exec-out screencap -p > "{2}"' -f $Adb, $TargetDevice, $Path
  & cmd.exe /d /c $command
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $Path)) {
    throw "Failed to capture screenshot: $Path"
  }
}

function Copy-DatabaseFromDevice {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$PackageId,
    [string]$Destination
  )
  foreach ($suffix in @('', '-wal', '-shm')) {
    $local = "$Destination$suffix"
    if (Test-Path -LiteralPath $local) { Remove-Item -LiteralPath $local -Force }
    $remote = "/data/data/$PackageId/databases/evefit_tracker.db$suffix"
    $pull = '"{0}" -s {1} pull "{2}" "{3}" >nul 2>nul' -f $Adb, $TargetDevice, $remote, $local
    & cmd.exe /d /c $pull | Out-Null
  }
  if (-not (Test-Path -LiteralPath $Destination)) {
    throw 'Failed to copy the application database from the emulator.'
  }
}

function Restore-DatabaseToDevice {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$PackageId,
    [string]$Source,
    [string]$Owner,
    [string]$Group
  )
  foreach ($suffix in @('', '-wal', '-shm')) {
    $local = "$Source$suffix"
    $remote = "/data/data/$PackageId/databases/evefit_tracker.db$suffix"
    & $Adb -s $TargetDevice shell rm -f $remote | Out-Null
    if (Test-Path -LiteralPath $local) {
      $staged = "/data/local/tmp/evefit_v112_upgrade.db$suffix"
      & $Adb -s $TargetDevice push $local $staged | Out-Null
      if ($LASTEXITCODE -ne 0) { throw "Failed to stage database file: $suffix" }
      & $Adb -s $TargetDevice shell cp $staged $remote | Out-Null
      & $Adb -s $TargetDevice shell chown "${Owner}:${Group}" $remote | Out-Null
      & $Adb -s $TargetDevice shell chmod 600 $remote | Out-Null
      & $Adb -s $TargetDevice shell rm -f $staged | Out-Null
    }
  }
}

function Get-ApkMetadata([string]$Aapt, [string]$Apk) {
  $line = (& $Aapt dump badging $Apk | Select-Object -First 1)
  if ($line -notmatch "package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'") {
    throw "Could not read APK metadata: $Apk"
  }
  return [pscustomobject]@{
    Package = $matches[1]
    VersionCode = [int]$matches[2]
    VersionName = $matches[3]
  }
}

function Get-ApkCertificate([string]$ApkSigner, [string]$Apk) {
  $line = & $ApkSigner verify --print-certs $Apk |
    Where-Object { $_ -match '^Signer #1 certificate SHA-256 digest:' } |
    Select-Object -First 1
  if (-not $line) { throw "Could not read APK certificate: $Apk" }
  return ($line -split ': ', 2)[1].Trim().ToLowerInvariant()
}

try {
  $repository = Get-EveFitRepositoryRoot
  $BaselineApk = (Resolve-Path -LiteralPath $BaselineApk).Path
  if (-not $CurrentApk) {
    $CurrentApk = Join-Path $repository 'build\app\outputs\flutter-apk\app-release.apk'
  }
  $CurrentApk = (Resolve-Path -LiteralPath $CurrentApk).Path
  $adb = Get-EveFitAndroidTool 'adb'
  $python = (Get-Command python -ErrorAction Stop).Source
  $sdk = Get-EveFitAndroidSdkRoot
  $buildTools = Get-ChildItem (Join-Path $sdk 'build-tools') -Directory |
    Sort-Object Name -Descending |
    Select-Object -First 1
  if (-not $buildTools) { throw 'Android build-tools were not found.' }
  $aapt = Join-Path $buildTools.FullName 'aapt.exe'
  $apkSigner = Join-Path $buildTools.FullName 'apksigner.bat'
  $packageId = Get-EveFitPackageId
  $baselineMetadata = Get-ApkMetadata $aapt $BaselineApk
  $currentMetadata = Get-ApkMetadata $aapt $CurrentApk
  if ($baselineMetadata.Package -ne $packageId -or $baselineMetadata.VersionName -ne '1.1.1' -or $baselineMetadata.VersionCode -ne 3) {
    throw 'The baseline APK is not EveFit v1.1.1 build 3.'
  }
  if ($currentMetadata.Package -ne $packageId -or $currentMetadata.VersionName -ne '1.1.2' -or $currentMetadata.VersionCode -ne 4) {
    throw 'The current APK is not EveFit v1.1.2 build 4.'
  }
  $baselineCertificate = Get-ApkCertificate $apkSigner $BaselineApk
  $currentCertificate = Get-ApkCertificate $apkSigner $CurrentApk
  if ($baselineCertificate -ne $currentCertificate) {
    throw 'SIGNING_INCOMPATIBILITY: the v1.1.1 and v1.1.2 certificates differ.'
  }

  $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
  if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
  $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
  if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
  $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)
  & $adb -s $DeviceId root | Out-Null
  Start-Sleep -Seconds 2
  & $adb -s $DeviceId wait-for-device
  if ((& $adb -s $DeviceId shell id) -notmatch 'uid=0\(root\)') {
    throw 'The upgrade test requires root access on the laboratory AVD.'
  }

  $timestamp = Get-EveFitTimestamp
  $runDirectory = Join-Path $repository "test_artifacts\release\v1.1.2\upgrade\$timestamp"
  $screenshots = Join-Path $runDirectory 'screenshots'
  New-Item -ItemType Directory -Force -Path $screenshots | Out-Null
  & $adb -s $DeviceId uninstall $packageId 2>$null | Out-Null
  & $adb -s $DeviceId install $BaselineApk | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'Failed to install the v1.1.1 APK.' }
  & $adb -s $DeviceId shell am start -n "$packageId/.MainActivity" | Out-Null
  $deadline = [DateTime]::UtcNow.AddSeconds(60)
  do {
    $databasePath = "/data/data/$packageId/databases/evefit_tracker.db"
    $databaseSize = (& $adb -s $DeviceId shell "if [ -f '$databasePath' ]; then stat -c %s '$databasePath'; else echo 0; fi").Trim()
    if ($databaseSize -match '^\d+$' -and [int64]$databaseSize -ge 100000) { break }
    Start-Sleep -Seconds 1
  } while ([DateTime]::UtcNow -lt $deadline)
  if ($databaseSize -notmatch '^\d+$' -or [int64]$databaseSize -lt 100000) {
    throw 'The v1.1.1 APK did not finish creating its database.'
  }
  & $adb -s $DeviceId shell am force-stop $packageId | Out-Null
  $owner = (& $adb -s $DeviceId shell stat -c '%u' $databasePath).Trim()
  $group = (& $adb -s $DeviceId shell stat -c '%g' $databasePath).Trim()
  $database = Join-Path $runDirectory 'evefit_tracker_before.db'
  Copy-DatabaseFromDevice $adb $DeviceId $packageId $database
  $helper = Join-Path $repository 'tool\v111_official_upgrade_database_helper.py'
  $beforeJson = & $python $helper --mode prepare --database $database
  if ($LASTEXITCODE -ne 0) { throw 'Failed to prepare the representative v1.1.1 database.' }
  $before = $beforeJson | ConvertFrom-Json
  Restore-DatabaseToDevice $adb $DeviceId $packageId $database $owner $group
  $before | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $runDirectory 'before.json') -Encoding utf8

  & $adb -s $DeviceId install -r $CurrentApk | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'adb install -r failed for the v1.1.2 APK.' }
  & $adb -s $DeviceId logcat -c | Out-Null
  & $adb -s $DeviceId shell am start -n "$packageId/.MainActivity" | Out-Null
  Start-Sleep -Seconds 8
  if (-not ((& $adb -s $DeviceId shell pidof $packageId).Trim())) {
    throw 'The upgraded app did not remain running.'
  }
  $fatal = & $adb -s $DeviceId logcat -d -t 800 |
    Select-String -Pattern 'FATAL EXCEPTION|Foreign key constraint failed|DatabaseException'
  if ($fatal) { throw "The upgraded app logged a fatal database/runtime error: $fatal" }

  $profileChoice = Wait-UiNode $adb $DeviceId 'Upgrade official v1.1.0' '' 10
  if ($profileChoice) { Invoke-UiTap $adb $DeviceId $profileChoice }
  $pinField = Wait-UiNode $adb $DeviceId '' 'android.widget.EditText'
  if (-not $pinField) { throw 'The upgraded profile PIN field was not visible.' }
  Invoke-UiTap $adb $DeviceId $pinField
  & $adb -s $DeviceId shell input text 1234 | Out-Null
  $enter = Wait-UiNode $adb $DeviceId 'Entrar' ''
  if (-not $enter) { throw 'The upgraded profile login action was not visible.' }
  Invoke-UiTap $adb $DeviceId $enter
  if (-not (Wait-UiNode $adb $DeviceId 'Dashboard' '')) {
    throw 'The upgraded profile did not reach Dashboard.'
  }
  Save-Screenshot $adb $DeviceId (Join-Path $screenshots '01_dashboard_after_upgrade.png')
  $workouts = Wait-UiNode $adb $DeviceId 'Treinos' ''
  if (-not $workouts) { throw 'The workouts navigation item was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $workouts
  $workout = Wait-UiNode $adb $DeviceId 'Treino upgrade oficial' ''
  if (-not $workout) { throw 'The representative workout was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $workout
  if (-not (Wait-UiNode $adb $DeviceId 'Detalhe do treino' '' 60)) {
    throw 'The historical workout detail did not finish opening after upgrade.'
  }
  $addExercise = Wait-UiNode $adb $DeviceId 'Adicionar exerc' '' 20
  if (-not $addExercise) { throw 'The historical workout detail did not open after upgrade.' }
  Save-Screenshot $adb $DeviceId (Join-Path $screenshots '02_workout_after_upgrade.png')
  Invoke-UiTap $adb $DeviceId $addExercise
  if (-not (Wait-UiNode $adb $DeviceId 'Em que contexto vais utilizar o exerc' '' 20)) {
    throw 'The hierarchical selector context step did not open after upgrade.'
  }
  $mainTraining = Wait-UiNode $adb $DeviceId 'Treino principal' '' 10
  $warmup = Wait-UiNode $adb $DeviceId 'Aquecimento' '' 10
  if (-not $mainTraining -or -not $warmup) {
    throw 'The first approved contexts were not visible after upgrade.'
  }
  if ([int](($mainTraining.bounds -split ',|\]')[1]) -ge [int](($warmup.bounds -split ',|\]')[1])) {
    throw 'Treino principal is not the first visible context.'
  }
  Invoke-UiTap $adb $DeviceId $warmup
  if (-not (Wait-UiNode $adb $DeviceId 'Que capacidade queres trabalhar?' '' 20)) {
    throw 'The capability step did not open after upgrade.'
  }
  Find-And-TapWithScroll $adb $DeviceId 'Cardio e condicionamento'
  if (-not (Wait-UiNode $adb $DeviceId 'conceitos de treino aprovados' '' 20)) {
    throw 'The approved concept empty state was not visible after upgrade.'
  }
  Save-Screenshot $adb $DeviceId (Join-Path $screenshots '03_hierarchical_empty_after_upgrade.png')

  & $adb -s $DeviceId shell am force-stop $packageId | Out-Null
  $afterDatabase = Join-Path $runDirectory 'evefit_tracker_after.db'
  Copy-DatabaseFromDevice $adb $DeviceId $packageId $afterDatabase
  $afterJson = & $python $helper --mode verify --database $afterDatabase
  if ($LASTEXITCODE -ne 0) { throw 'Failed to verify the upgraded v1.1.2 database.' }
  $after = $afterJson | ConvertFrom-Json
  foreach ($table in @('profiles', 'body_measurements', 'goals', 'workouts', 'workout_sets', 'workout_exercises', 'exercises')) {
    $beforeCount = [int]$before.counts.$table
    $afterCount = [int]$after.counts.$table
    if ($afterCount -lt $beforeCount) {
      throw "DATA_PRESERVATION_FAILURE: $table decreased from $beforeCount to $afterCount."
    }
    "EVEFIT_V112_UPGRADE_BEFORE_$($table.ToUpper())=$beforeCount"
    "EVEFIT_V112_UPGRADE_AFTER_$($table.ToUpper())=$afterCount"
  }
  if (@($after.foreign_keys).Count -ne 0) { throw 'Foreign key verification failed.' }
  if (-not $after.profile -or -not $after.measurement -or -not $after.goal -or -not $after.workout) {
    throw 'One or more representative personal records were not preserved.'
  }
  $after | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $runDirectory 'after.json') -Encoding utf8
  & $adb -s $DeviceId logcat -d | Set-Content -LiteralPath (Join-Path $runDirectory 'logcat.log') -Encoding utf8
  Write-EveFitMetadata -Path (Join-Path $runDirectory 'metadata.json') -DeviceId $DeviceId
  "EVEFIT_V112_BASELINE_VERSION=$($baselineMetadata.VersionName)+$($baselineMetadata.VersionCode)"
  "EVEFIT_V112_CURRENT_VERSION=$($currentMetadata.VersionName)+$($currentMetadata.VersionCode)"
  "EVEFIT_V112_CERTIFICATE_SHA256=$currentCertificate"
  'EVEFIT_V112_FOREIGN_KEYS_VALID=true'
  'EVEFIT_V112_PERSONAL_DATA_PRESERVED=true'
  'EVEFIT_V112_HIERARCHICAL_SEARCH_VISIBLE=true'
  'EVEFIT_V112_LEGACY_VISIBLE=false'
  "UPGRADE_RUN_DIRECTORY=$runDirectory"
  'UPGRADE_EXIT_CODE=0'
  exit 0
} catch {
  Write-Error $_
  exit 1
}
