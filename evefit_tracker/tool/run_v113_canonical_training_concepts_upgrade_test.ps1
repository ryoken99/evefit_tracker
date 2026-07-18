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
  $remote = '/sdcard/evefit_v113_upgrade_window.xml'
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

function Find-UiNodeWithScroll {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [string]$Text,
    [int]$Attempts = 10
  )
  for ($attempt = 0; $attempt -lt $Attempts; $attempt++) {
    $node = Wait-UiNode $Adb $TargetDevice $Text '' 2
    if ($node) { return $node }
    & $Adb -s $TargetDevice shell input swipe 700 2200 700 700 300 | Out-Null
    Start-Sleep -Milliseconds 400
  }
  return $null
}

function Scroll-UiListToTop {
  param(
    [string]$Adb,
    [string]$TargetDevice,
    [int]$Attempts = 10
  )
  for ($attempt = 0; $attempt -lt $Attempts; $attempt++) {
    & $Adb -s $TargetDevice shell input swipe 700 700 700 2200 300 | Out-Null
    Start-Sleep -Milliseconds 400
  }
}

function Require-UiTextWithScroll([string]$Adb, [string]$TargetDevice, [string]$Text) {
  if (-not (Find-UiNodeWithScroll $Adb $TargetDevice $Text)) {
    throw "Required UI text was not visible: $Text"
  }
}

function Save-Screenshot([string]$Adb, [string]$TargetDevice, [string]$Path) {
  $command = '"{0}" -s {1} exec-out screencap -p > "{2}"' -f $Adb, $TargetDevice, $Path
  & cmd.exe /d /c $command
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $Path)) {
    throw "Failed to capture screenshot: $Path"
  }
}

function Copy-DatabaseFromDevice {
  param([string]$Adb, [string]$TargetDevice, [string]$PackageId, [string]$Destination)
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
      $staged = "/data/local/tmp/evefit_v113_upgrade.db$suffix"
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

function Get-ApkSignature([string]$ApkSigner, [string]$Apk) {
  $output = (& $ApkSigner verify --verbose --print-certs $Apk) -join "`n"
  if ($LASTEXITCODE -ne 0) { throw "APK signature verification failed: $Apk" }
  if ($output -notmatch 'Verified using v2 scheme \(APK Signature Scheme v2\): true') {
    throw "APK does not use signature scheme v2: $Apk"
  }
  $digest = [regex]::Match($output, 'Signer #1 certificate SHA-256 digest:\s*([0-9A-Fa-f]+)')
  $subject = [regex]::Match($output, 'Signer #1 certificate DN:\s*(.+)')
  if (-not $digest.Success -or -not $subject.Success) {
    throw "Could not read APK signing certificate: $Apk"
  }
  return [pscustomobject]@{
    Digest = $digest.Groups[1].Value.ToUpperInvariant()
    Subject = $subject.Groups[1].Value.Trim()
  }
}

$databaseHelper = @'
import hashlib
import json
import sqlite3
import sys

TABLES = (
    'profiles', 'body_measurements', 'goals', 'workouts',
    'workout_exercises', 'workout_sets', 'exercises', 'dashboard_widgets',
)


def one(connection, query, values=()):
    return connection.execute(query, values).fetchone() is not None


def snapshot(connection):
    counts = {
        table: connection.execute(f'SELECT COUNT(*) FROM {table}').fetchone()[0]
        for table in TABLES
    }
    schema_rows = connection.execute(
        "SELECT type, name, tbl_name, COALESCE(sql, '') FROM sqlite_master "
        "WHERE type IN ('index', 'table', 'trigger', 'view') "
        'ORDER BY type, name'
    ).fetchall()
    return {
        'counts': counts,
        'foreign_keys': connection.execute('PRAGMA foreign_key_check').fetchall(),
        'schema_json': json.dumps(schema_rows, separators=(',', ':')),
        'user_version': connection.execute('PRAGMA user_version').fetchone()[0],
        'markers': {
            'profile': one(connection, "SELECT 1 FROM profiles WHERE notes = 'v113-upgrade-profile'"),
            'measurement': one(connection, "SELECT 1 FROM body_measurements WHERE notes = 'v113-upgrade-measurement'"),
            'goal': one(connection, "SELECT 1 FROM goals WHERE title = 'Upgrade v1.1.2 goal'"),
            'workout': one(connection, "SELECT 1 FROM workouts WHERE notes = 'v113-upgrade-workout'"),
            'workout_exercise': one(connection, "SELECT 1 FROM workout_exercises WHERE notes = 'v113-upgrade-workout-exercise'"),
            'workout_set': one(connection, "SELECT 1 FROM workout_sets WHERE notes = 'v113-upgrade-workout-set'"),
            'settings': one(connection, "SELECT 1 FROM dashboard_widgets WHERE metric_key = 'v113-upgrade-setting' AND title = 'Upgrade setting' AND is_visible = 0 AND sort_order = 77"),
            'historical_join': one(connection, "SELECT 1 FROM workouts w JOIN workout_exercises we ON we.workout_id = w.id JOIN workout_sets ws ON ws.workout_id = w.id AND ws.exercise_id = we.exercise_id JOIN exercises e ON e.id = we.exercise_id WHERE w.notes = 'v113-upgrade-workout' AND we.notes = 'v113-upgrade-workout-exercise' AND ws.notes = 'v113-upgrade-workout-set' AND e.notes = 'v113-upgrade-historical-exercise'"),
        },
    }


def prepare(connection):
    now = '2026-07-18T12:00:00.000Z'
    pin_hash = hashlib.sha256(b'evefit-tracker-local-pin-v1:1234').hexdigest()
    connection.execute(
        'INSERT INTO profiles(name,pin_hash,created_at,updated_at,is_active,height_cm,training_location,initial_goals,notes) VALUES(?,?,?,?,?,?,?,?,?)',
        ('Upgrade v1.1.2', pin_hash, now, now, 1, 180.0, 'home', 'preserve-upgrade-settings', 'v113-upgrade-profile'),
    )
    profile_id = connection.execute('SELECT last_insert_rowid()').fetchone()[0]
    connection.execute(
        'INSERT INTO body_measurements(profile_id,date,weight_kg,notes) VALUES(?,?,?,?)',
        (profile_id, now, 80.0, 'v113-upgrade-measurement'),
    )
    connection.execute(
        'INSERT INTO goals(profile_id,title,description,phase,category,metric_key,is_active,created_at) VALUES(?,?,?,?,?,?,?,?)',
        (profile_id, 'Upgrade v1.1.2 goal', 'must survive v1.1.3', 'Base', 'Outro', 'manual', 1, now),
    )
    connection.execute(
        'INSERT INTO workouts(profile_id,date,workout_type,duration_minutes,notes) VALUES(?,?,?,?,?)',
        (profile_id, now, 'Treino upgrade v1.1.2', 30, 'v113-upgrade-workout'),
    )
    workout_id = connection.execute('SELECT last_insert_rowid()').fetchone()[0]
    connection.execute(
        'INSERT INTO exercises(name,muscle_group,is_default,notes) VALUES(?,?,?,?)',
        ('Upgrade v1.1.2 historical exercise', 'Outro', 0, 'v113-upgrade-historical-exercise'),
    )
    exercise_id = connection.execute('SELECT last_insert_rowid()').fetchone()[0]
    connection.execute(
        'INSERT INTO workout_exercises(profile_id,workout_id,exercise_id,notes) VALUES(?,?,?,?)',
        (profile_id, workout_id, exercise_id, 'v113-upgrade-workout-exercise'),
    )
    connection.execute(
        'INSERT INTO workout_sets(profile_id,workout_id,exercise_id,set_number,reps,notes) VALUES(?,?,?,?,?,?)',
        (profile_id, workout_id, exercise_id, 1, 12, 'v113-upgrade-workout-set'),
    )
    connection.execute(
        'INSERT INTO dashboard_widgets(profile_id,metric_key,title,is_visible,sort_order,created_at,updated_at,explicitly_configured_at) VALUES(?,?,?,?,?,?,?,?)',
        (profile_id, 'v113-upgrade-setting', 'Upgrade setting', 0, 77, now, now, now),
    )
    connection.commit()
    return snapshot(connection)


connection = sqlite3.connect(sys.argv[2])
try:
    result = prepare(connection) if sys.argv[1] == 'prepare' else snapshot(connection)
    print(json.dumps(result, ensure_ascii=True))
finally:
    connection.close()
'@

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
  $buildTools = Get-ChildItem (Join-Path $sdk 'build-tools') -Directory | Sort-Object Name -Descending | Select-Object -First 1
  if (-not $buildTools) { throw 'Android build-tools were not found.' }
  $aapt = Join-Path $buildTools.FullName 'aapt.exe'
  $apkSigner = Join-Path $buildTools.FullName 'apksigner.bat'
  $packageId = Get-EveFitPackageId
  $expectedCertificate = '59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B'
  $baselineMetadata = Get-ApkMetadata $aapt $BaselineApk
  $currentMetadata = Get-ApkMetadata $aapt $CurrentApk
  if ($baselineMetadata.Package -ne $packageId -or $baselineMetadata.VersionName -ne '1.1.2' -or $baselineMetadata.VersionCode -ne 4) {
    throw 'The baseline APK is not EveFit v1.1.2 build 4.'
  }
  if ($currentMetadata.Package -ne $packageId -or $currentMetadata.VersionName -ne '1.1.3' -or $currentMetadata.VersionCode -ne 5) {
    throw 'The current APK is not EveFit v1.1.3 build 5.'
  }
  $baselineSignature = Get-ApkSignature $apkSigner $BaselineApk
  $currentSignature = Get-ApkSignature $apkSigner $CurrentApk
  if ($baselineSignature.Digest -ne $expectedCertificate -or $currentSignature.Digest -ne $expectedCertificate -or $baselineSignature.Digest -ne $currentSignature.Digest) {
    throw 'SIGNING_INCOMPATIBILITY: the v1.1.2 and v1.1.3 certificates do not match the required certificate.'
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
  $runDirectory = Join-Path $repository "test_artifacts\release\v1.1.3\upgrade\$timestamp"
  $screenshots = Join-Path $runDirectory 'screenshots'
  New-Item -ItemType Directory -Force -Path $screenshots | Out-Null
  $databaseHelperPath = Join-Path $runDirectory 'database_helper.py'
  $databaseHelper | Set-Content -LiteralPath $databaseHelperPath -Encoding utf8
  & $adb -s $DeviceId uninstall $packageId 2>$null | Out-Null
  & $adb -s $DeviceId install $BaselineApk | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'Failed to install the v1.1.2 APK.' }
  & $adb -s $DeviceId shell am start -n "$packageId/.MainActivity" | Out-Null
  $deadline = [DateTime]::UtcNow.AddSeconds(60)
  do {
    $databasePath = "/data/data/$packageId/databases/evefit_tracker.db"
    $databaseSize = (& $adb -s $DeviceId shell "if [ -f '$databasePath' ]; then stat -c %s '$databasePath'; else echo 0; fi").Trim()
    if ($databaseSize -match '^\d+$' -and [int64]$databaseSize -ge 100000) { break }
    Start-Sleep -Seconds 1
  } while ([DateTime]::UtcNow -lt $deadline)
  if ($databaseSize -notmatch '^\d+$' -or [int64]$databaseSize -lt 100000) {
    throw 'The v1.1.2 APK did not finish creating its database.'
  }
  & $adb -s $DeviceId shell am force-stop $packageId | Out-Null
  $owner = (& $adb -s $DeviceId shell stat -c '%u' $databasePath).Trim()
  $group = (& $adb -s $DeviceId shell stat -c '%g' $databasePath).Trim()
  $database = Join-Path $runDirectory 'evefit_tracker_before.db'
  Copy-DatabaseFromDevice $adb $DeviceId $packageId $database
  $beforeJson = & $python $databaseHelperPath prepare $database
  if ($LASTEXITCODE -ne 0) { throw 'Failed to prepare the representative v1.1.2 database.' }
  $before = $beforeJson | ConvertFrom-Json
  Restore-DatabaseToDevice $adb $DeviceId $packageId $database $owner $group
  $before | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDirectory 'before.json') -Encoding utf8

  & $adb -s $DeviceId install -r $CurrentApk | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'adb install -r failed for the v1.1.3 APK.' }
  & $adb -s $DeviceId logcat -c | Out-Null
  & $adb -s $DeviceId shell am start -n "$packageId/.MainActivity" | Out-Null
  Start-Sleep -Seconds 8
  if (-not ((& $adb -s $DeviceId shell pidof $packageId).Trim())) {
    throw 'The upgraded app did not remain running.'
  }
  $fatal = & $adb -s $DeviceId logcat -d -t 800 | Select-String -Pattern 'FATAL EXCEPTION|Foreign key constraint failed|DatabaseException'
  if ($fatal) { throw "The upgraded app logged a fatal database/runtime error: $fatal" }

  $profileChoice = Wait-UiNode $adb $DeviceId 'Upgrade v1.1.2' '' 10
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
  $workout = Wait-UiNode $adb $DeviceId 'Treino upgrade v1.1.2' ''
  if (-not $workout) { throw 'The representative workout was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $workout
  if (-not (Wait-UiNode $adb $DeviceId 'Detalhe do treino' '' 60)) {
    throw 'The historical workout detail did not finish opening after upgrade.'
  }
  $addExercise = Wait-UiNode $adb $DeviceId 'Adicionar exerc' '' 20
  if (-not $addExercise) { throw 'The historical workout detail did not open after upgrade.' }
  Save-Screenshot $adb $DeviceId (Join-Path $screenshots '02_historical_workout_after_upgrade.png')
  Invoke-UiTap $adb $DeviceId $addExercise
  if (-not (Wait-UiNode $adb $DeviceId 'Em que contexto vais utilizar o exerc' '' 20)) {
    throw 'The hierarchical selector context step did not open after upgrade.'
  }
  $mainTraining = Wait-UiNode $adb $DeviceId 'Treino principal' '' 10
  if (-not $mainTraining) { throw 'The main training context was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $mainTraining
  if (-not (Wait-UiNode $adb $DeviceId 'Que capacidade queres trabalhar' '' 20)) {
    throw 'The capability step did not open after upgrade.'
  }
  $cardio = Find-UiNodeWithScroll $adb $DeviceId 'Cardio e condicionamento'
  if (-not $cardio) { throw 'The cardio capability was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $cardio
  if (-not (Wait-UiNode $adb $DeviceId 'Que tipo de trabalho funcional procuras' '' 20)) {
    throw 'The training concept step did not open after upgrade.'
  }
  foreach ($text in @('Locomo', 'Propuls', 'Movimento r', 'Deslocamento multidirecional', 'Sequ')) {
    Require-UiTextWithScroll $adb $DeviceId $text
  }
  Scroll-UiListToTop $adb $DeviceId
  foreach ($text in @('Deslocar o corpo', 'Produzir repetidamente', 'Repetir regularmente', 'Deslocar-se repetidamente', 'Encadear v')) {
    Require-UiTextWithScroll $adb $DeviceId $text
  }
  if (Wait-UiNode $adb $DeviceId 'Upgrade v1.1.2 historical exercise' '' 3) {
    throw 'LEGACY_VISIBLE: the representative legacy exercise is visible in the canonical selector.'
  }
  Scroll-UiListToTop $adb $DeviceId
  $concept = Find-UiNodeWithScroll $adb $DeviceId 'Locomo'
  if (-not $concept) { throw 'Cyclic locomotion was not visible after upgrade.' }
  Invoke-UiTap $adb $DeviceId $concept
  if (-not (Wait-UiNode $adb $DeviceId 'Ainda n' '' 20)) {
    throw 'The approved empty training intention state was not visible after concept selection.'
  }
  if (-not (Wait-UiNode $adb $DeviceId 'As inten' '' 10)) {
    throw 'The training intention empty-state explanation was not visible.'
  }
  if (-not (Wait-UiNode $adb $DeviceId 'Treino principal' '' 10)) {
    throw 'The selected context was not preserved in the intention breadcrumb.'
  }
  Save-Screenshot $adb $DeviceId (Join-Path $screenshots '03_training_concepts_after_upgrade.png')

  & $adb -s $DeviceId shell am force-stop $packageId | Out-Null
  $afterDatabase = Join-Path $runDirectory 'evefit_tracker_after.db'
  Copy-DatabaseFromDevice $adb $DeviceId $packageId $afterDatabase
  $afterJson = & $python $databaseHelperPath verify $afterDatabase
  if ($LASTEXITCODE -ne 0) { throw 'Failed to verify the upgraded v1.1.3 database.' }
  $after = $afterJson | ConvertFrom-Json
  foreach ($table in @('profiles', 'body_measurements', 'goals', 'workouts', 'workout_exercises', 'workout_sets', 'dashboard_widgets')) {
    $beforeCount = [int]$before.counts.$table
    $afterCount = [int]$after.counts.$table
    if ($afterCount -lt $beforeCount) {
      throw "DATA_PRESERVATION_FAILURE: $table decreased from $beforeCount to $afterCount."
    }
    "EVEFIT_V113_UPGRADE_BEFORE_$($table.ToUpper())=$beforeCount"
    "EVEFIT_V113_UPGRADE_AFTER_$($table.ToUpper())=$afterCount"
  }
  if (@($after.foreign_keys).Count -ne 0) { throw 'Foreign key verification failed.' }
  if ($before.user_version -ne $after.user_version -or $before.schema_json -ne $after.schema_json) {
    throw 'SCHEMA_OR_MIGRATION_CHANGE: the upgrade changed the database schema or user_version.'
  }
  foreach ($marker in @('profile', 'measurement', 'goal', 'workout', 'workout_exercise', 'workout_set', 'settings', 'historical_join')) {
    if (-not $after.markers.$marker) { throw "DATA_PRESERVATION_FAILURE: missing $marker marker after upgrade." }
  }
  $after | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDirectory 'after.json') -Encoding utf8
  & $adb -s $DeviceId logcat -d | Set-Content -LiteralPath (Join-Path $runDirectory 'logcat.log') -Encoding utf8
  Write-EveFitMetadata -Path (Join-Path $runDirectory 'metadata.json') -DeviceId $DeviceId
  "EVEFIT_V113_BASELINE_VERSION=$($baselineMetadata.VersionName)+$($baselineMetadata.VersionCode)"
  "EVEFIT_V113_CURRENT_VERSION=$($currentMetadata.VersionName)+$($currentMetadata.VersionCode)"
  "EVEFIT_V113_CERTIFICATE_SUBJECT=$($currentSignature.Subject)"
  "EVEFIT_V113_CERTIFICATE_SHA256=$($currentSignature.Digest)"
  'EVEFIT_V113_APK_SIGNATURE_SCHEME_V2=true'
  'EVEFIT_V113_FOREIGN_KEYS_VALID=true'
  'EVEFIT_V113_SCHEMA_UNCHANGED=true'
  'EVEFIT_V113_PERSONAL_DATA_PRESERVED=true'
  'EVEFIT_V113_SETTINGS_PRESERVED=true'
  'EVEFIT_V113_HISTORICAL_DATA_ACCESSIBLE=true'
  'EVEFIT_V113_TRAINING_CONCEPTS_VISIBLE=true'
  'EVEFIT_V113_LEGACY_VISIBLE=false'
  "UPGRADE_RUN_DIRECTORY=$runDirectory"
  'UPGRADE_EXIT_CODE=0'
  exit 0
} catch {
  Write-Error $_
  exit 1
}
