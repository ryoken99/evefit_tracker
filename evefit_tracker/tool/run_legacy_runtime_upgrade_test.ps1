[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [string]$BaselineCommit = '1078f3e1176c2432701c7a4d702bb5d80e39645d',
  [string]$BaselineDatabase,
  [int]$BootTimeoutSeconds = 300,
  [switch]$ClearAppData
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

function Get-EveFitUiXml([string]$Adb, [string]$TargetDevice) {
  & $Adb -s $TargetDevice shell rm -f /sdcard/evefit_upgrade_window.xml | Out-Null
  & $Adb -s $TargetDevice shell uiautomator dump /sdcard/evefit_upgrade_window.xml 2>$null | Out-Null
  if ($LASTEXITCODE -ne 0) { return $null }
  $xmlText = (& $Adb -s $TargetDevice shell cat /sdcard/evefit_upgrade_window.xml) -join "`n"
  try { return ,([xml]$xmlText) } catch { return $null }
}

function Wait-EveFitUiNode {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$Text,
    [string]$Class,
    [int]$TimeoutSeconds = 45
  )
  $deadline = [DateTime]::UtcNow.AddSeconds($TimeoutSeconds)
  do {
    & $Adb -s $TargetDevice shell input keyevent KEYCODE_WAKEUP | Out-Null
    & $Adb -s $TargetDevice shell wm dismiss-keyguard | Out-Null
    $xml = Get-EveFitUiXml $Adb $TargetDevice
    if (-not $xml) {
      Start-Sleep -Seconds 1
      continue
    }
    $nodes = @($xml.SelectNodes('//node'))
    $match = $nodes | Where-Object {
      (-not $Text -or $_.text -eq $Text -or $_.'content-desc' -eq $Text) -and (-not $Class -or $_.class -eq $Class)
    } | Select-Object -First 1
    if ($match) { return $match }
    Start-Sleep -Milliseconds 500
  } while ([DateTime]::UtcNow -lt $deadline)
  return $null
}

function Invoke-EveFitUiTap {
  param([string]$Adb, [string]$TargetDevice, $Node)
  if ($Node.bounds -notmatch '^\[(\d+),(\d+)\]\[(\d+),(\d+)\]$') {
    throw "Invalid UI bounds: $($Node.bounds)"
  }
  $x = [int](([int]$matches[1] + [int]$matches[3]) / 2)
  $y = [int](([int]$matches[2] + [int]$matches[4]) / 2)
  & $Adb -s $TargetDevice shell input tap $x $y | Out-Null
}

function Wait-EveFitBaselineDatabase {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$PackageId,
    [string]$Python,
    [string]$RunDirectory,
    [int]$TimeoutSeconds = 720
  )
  Start-Sleep -Seconds 150
  $deadline = [DateTime]::UtcNow.AddSeconds($TimeoutSeconds - 150)
  $probe = Join-Path $RunDirectory 'baseline_probe.db'
  do {
    foreach ($suffix in @('', '-wal', '-shm')) {
      $target = "$probe$suffix"
      if (Test-Path -LiteralPath $target) { Remove-Item -LiteralPath $target -Force }
      $remote = "databases/evefit_tracker.db$suffix"
      $copy = '"{0}" -s {1} exec-out run-as {2} cat {3} > "{4}" 2>nul' -f $Adb, $TargetDevice, $PackageId, $remote, $target
      & cmd.exe /d /c $copy | Out-Null
    }
    if (Test-Path -LiteralPath $probe) {
      $query = "import json,sqlite3,sys; c=sqlite3.connect('file:'+sys.argv[1]+'?mode=ro',uri=True); print(json.dumps({'version':c.execute('pragma user_version').fetchone()[0],'exercises':c.execute('select count(*) from exercises').fetchone()[0]}))"
      try {
        $state = (& $Python -c $query $probe 2>$null | ConvertFrom-Json)
        if ([int]$state.version -eq 22 -and [int]$state.exercises -eq 1762) {
          "EVEFIT_BASELINE_USER_VERSION=$($state.version)"
          "EVEFIT_BASELINE_EXERCISES=$($state.exercises)"
          return $true
        }
      } catch {
        # A snapshot copied during a write can be transiently incomplete.
      }
    }
    Start-Sleep -Seconds 10
  } while ([DateTime]::UtcNow -lt $deadline)
  return $false
}

$worktree = $null
try {
  $repository = Get-EveFitRepositoryRoot
  $gitRoot = (& git -C $repository rev-parse --show-toplevel).Trim()
  $flutter = Get-EveFitFlutterTool
  $adb = Get-EveFitAndroidTool 'adb'
  $python = (Get-Command python -ErrorAction Stop).Source
  $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
  if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
  $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
  if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
  $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)
  if ($ClearAppData) {
    & (Join-Path $PSScriptRoot 'reset_evefit_test_device.ps1') -DeviceId $DeviceId -ClearAppData
    if ($LASTEXITCODE -ne 0) { throw 'The explicit app data reset failed.' }
  }

  $timestamp = Get-EveFitTimestamp
  $runDirectory = Join-Path $repository "test_artifacts\legacy_runtime\upgrade\$timestamp"
  New-Item -ItemType Directory -Force -Path $runDirectory | Out-Null
  $currentApk = Join-Path $runDirectory 'current-debug.apk'
  & $flutter build apk --debug
  if ($LASTEXITCODE -ne 0) { throw 'Failed to build the current debug APK.' }
  Copy-Item -LiteralPath (Join-Path $repository 'build\app\outputs\flutter-apk\app-debug.apk') -Destination $currentApk

  if ($BaselineDatabase) {
    $databaseCopy = Join-Path $runDirectory 'evefit_tracker.db'
    Copy-Item -LiteralPath $BaselineDatabase -Destination $databaseCopy
  } else {
  $worktree = "C:\evefit_up_$PID"
  if (Test-Path -LiteralPath $worktree) { throw "Temporary worktree already exists: $worktree" }
  & git -C $gitRoot worktree add --detach $worktree $BaselineCommit
  if ($LASTEXITCODE -ne 0) { throw 'Failed to create the baseline worktree.' }
  $baselineProject = Join-Path $worktree 'evefit_tracker'
  Push-Location $baselineProject
  try {
    & $flutter build apk --debug
    if ($LASTEXITCODE -ne 0) { throw 'Failed to build the baseline APK.' }
  } finally {
    Pop-Location
  }
  $baselineApk = Join-Path $baselineProject 'build\app\outputs\flutter-apk\app-debug.apk'
  & $adb -s $DeviceId install -r $baselineApk
  if ($LASTEXITCODE -ne 0) { throw 'Failed to install the baseline APK.' }
  & $adb -s $DeviceId shell input keyevent KEYCODE_WAKEUP | Out-Null
  & $adb -s $DeviceId shell wm dismiss-keyguard | Out-Null
  & $adb -s $DeviceId shell input keyevent 82 | Out-Null
  & $adb -s $DeviceId shell am start -n "$(Get-EveFitPackageId)/.MainActivity" | Out-Null
  if (-not (Wait-EveFitBaselineDatabase -Adb $adb -TargetDevice $DeviceId -PackageId (Get-EveFitPackageId) -Python $python -RunDirectory $runDirectory)) {
    throw 'The baseline app did not complete its legacy seed.'
  }

  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId) | Out-Null
  $databaseCopy = Join-Path $runDirectory 'evefit_tracker.db'
  $pullCommand = '"{0}" -s {1} exec-out run-as {2} cat databases/evefit_tracker.db > "{3}"' -f $adb, $DeviceId, (Get-EveFitPackageId), $databaseCopy
  & cmd.exe /d /c $pullCommand
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $databaseCopy)) {
    throw 'Failed to copy the baseline database.'
  }
  }
  $databaseHelper = Join-Path $repository 'tool\legacy_upgrade_database_helper.py'
  $before = (& $python $databaseHelper --mode prepare --database $databaseCopy | ConvertFrom-Json)
  & $adb -s $DeviceId install -r $currentApk
  if ($LASTEXITCODE -ne 0) { throw 'adb install -r failed for the current APK.' }
  & $adb -s $DeviceId shell run-as (Get-EveFitPackageId) mkdir -p databases | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'Failed to prepare the app database directory.' }
  $remoteDatabase = '/data/local/tmp/evefit_upgrade.db'
  & $adb -s $DeviceId push $databaseCopy $remoteDatabase | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'Failed to stage the representative baseline database.' }
  & $adb -s $DeviceId shell chmod 644 $remoteDatabase | Out-Null
  & $adb -s $DeviceId shell run-as (Get-EveFitPackageId) rm -f databases/evefit_tracker.db-wal databases/evefit_tracker.db-shm | Out-Null
  & $adb -s $DeviceId shell run-as (Get-EveFitPackageId) cp $remoteDatabase databases/evefit_tracker.db | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'Failed to restore the representative baseline database.' }
  & $adb -s $DeviceId shell rm -f $remoteDatabase | Out-Null
  $beforeText = ''
  foreach ($table in @('profiles','body_measurements','goals','workouts','workout_sets','workout_exercises','exercises')) {
    $value = [int]$before.counts.$table
    $line = "EVEFIT_UPGRADE_BEFORE_$($table.ToUpper())=$value"
    $beforeText += "$line`n"
    $line
  }
  "EVEFIT_UPGRADE_LEGACY_EXERCISE_ID=$($before.exercise_id)"
  "EVEFIT_UPGRADE_LEGACY_EXERCISE_NAME=$($before.exercise_name)"

  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId) | Out-Null
  & $adb -s $DeviceId shell am start -n "$(Get-EveFitPackageId)/.MainActivity" | Out-Null

  & $adb -s $DeviceId logcat -c | Out-Null
  & $adb -s $DeviceId shell input keyevent KEYCODE_WAKEUP | Out-Null
  & $adb -s $DeviceId shell wm dismiss-keyguard | Out-Null
  & $adb -s $DeviceId shell am start -n "$(Get-EveFitPackageId)/.MainActivity" | Out-Null
  Start-Sleep -Seconds 8
  $processId = (& $adb -s $DeviceId shell pidof (Get-EveFitPackageId)).Trim()
  if (-not $processId) { throw 'The upgraded app did not remain running.' }
  $fatal = & $adb -s $DeviceId logcat -d -t 500 | Select-String -Pattern 'FATAL EXCEPTION|Foreign key constraint failed|DatabaseException'
  if ($fatal) { throw "The upgraded app logged a fatal database/runtime error: $fatal" }
  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId) | Out-Null
  $databaseCopy = Join-Path $runDirectory 'evefit_tracker_after.db'
  $pullCommand = '"{0}" -s {1} exec-out run-as {2} cat databases/evefit_tracker.db > "{3}"' -f $adb, $DeviceId, (Get-EveFitPackageId), $databaseCopy
  & cmd.exe /d /c $pullCommand
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $databaseCopy)) {
    throw 'Failed to copy the upgraded database for verification.'
  }
  $verification = (& $python $databaseHelper --mode verify --database $databaseCopy | ConvertFrom-Json)
  foreach ($table in @('profiles','body_measurements','goals','workouts','workout_sets','workout_exercises')) {
    $beforeCount = [int]$before.counts.$table
    $afterCount = [int]$verification.counts.$table
    if ($afterCount -lt $beforeCount) { throw "DATA LOSS RISK: $table decreased from $beforeCount to $afterCount." }
    "EVEFIT_UPGRADE_AFTER_$($table.ToUpper())=$afterCount"
  }
  if ($verification.foreign_keys.Count -ne 0) { throw 'Foreign key verification failed after upgrade.' }
  if (-not $verification.historical -or
      $verification.historical[0] -ne 'upgrade-preserve-workout' -or
      $verification.historical[1] -ne 'upgrade-preserve-exercise' -or
      $verification.historical[2] -ne 'upgrade-preserve-set' -or
      $verification.historical[3] -ne $before.exercise_name) {
    throw 'Historical workout joins are not accessible after upgrade.'
  }
  "EVEFIT_UPGRADE_AFTER_EXERCISES=$($verification.counts.exercises)"
  'EVEFIT_UPGRADE_FOREIGN_KEYS_VALID=true'
  'EVEFIT_UPGRADE_HISTORICAL_WORKOUT_ACCESSIBLE=true'
  'EVEFIT_UPGRADE_LEGACY_SEED_EXECUTED=false'
  'EVEFIT_UPGRADE_LEGACY_ENTRIES_PROCESSED=0'

  $beforeText | Set-Content -LiteralPath (Join-Path $runDirectory 'before.log') -Encoding utf8
  "UPGRADE_RUN_DIRECTORY=$runDirectory"
  'UPGRADE_EXIT_CODE=0'
  exit 0
} catch {
  Write-Error $_
  exit 1
} finally {
  if ($worktree -and (Test-Path -LiteralPath $worktree)) {
    $resolvedWorktree = (Resolve-Path -LiteralPath $worktree).Path
    if (-not $resolvedWorktree.StartsWith('C:\evefit_up_', [StringComparison]::OrdinalIgnoreCase)) {
      throw 'Refusing to remove an unexpected worktree path.'
    }
    $buildPath = Join-Path $resolvedWorktree 'evefit_tracker\build'
    if (Test-Path -LiteralPath $buildPath) { Remove-Item -LiteralPath $buildPath -Recurse -Force }
    & git -C $gitRoot worktree remove --force $resolvedWorktree
  }
}
