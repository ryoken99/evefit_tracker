[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [int]$BootTimeoutSeconds = 300,
  [string]$ExpectedBranch,
  [string]$ExpectedCommit,
  [switch]$ClearAppData
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

function Save-AndroidSmokeAdbScreenshot(
  [string]$Adb,
  [string]$TargetDevice,
  [string]$DestinationDirectory
) {
  if (-not $TargetDevice) { return $null }

  $destination = Join-Path $DestinationDirectory 'adb_failure.png'
  $command = '"{0}" -s {1} exec-out screencap -p > "{2}"' -f $Adb, $TargetDevice, $destination
  $process = Start-Process -FilePath 'cmd.exe' -ArgumentList @('/d', '/c', $command) -PassThru -WindowStyle Hidden
  if (-not $process.WaitForExit(30000)) {
    Stop-Process -Id $process.Id -Force
    Get-CimInstance Win32_Process |
      Where-Object {
        $_.Name -eq 'adb.exe' -and
        $_.CommandLine -match [regex]::Escape("-s $TargetDevice exec-out screencap")
      } |
      ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
    Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
    return $null
  }
  if (
    $process.ExitCode -ne 0 -or
    -not (Test-Path -LiteralPath $destination) -or
    (Get-Item -LiteralPath $destination).Length -le 8
  ) {
    Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
    return $null
  }
  return $destination
}

$logcatProcess = $null
$runDirectory = $null
$metadataPath = $null
$stdout = $null
$stderr = $null
$combined = $null
$logcat = $null
$gitState = $null
$DeviceId = $DeviceId
$result = $null
$finalExitCode = 1
$failureMessage = $null
$started = [System.Diagnostics.Stopwatch]::StartNew()

try {
  $repository = Get-EveFitRepositoryRoot
  $gitState = Assert-EveFitGitExpectation -ExpectedBranch $ExpectedBranch -ExpectedCommit $ExpectedCommit
  $adb = Get-EveFitAndroidTool 'adb'
  $flutter = Get-EveFitFlutterTool
  $timestamp = Get-EveFitTimestamp
  $runDirectory = Join-Path $repository "test_artifacts\test_ci_performance\android_smoke\$timestamp"
  New-Item -ItemType Directory -Force -Path $runDirectory | Out-Null
  $stdout = Join-Path $runDirectory 'flutter.stdout.log'
  $stderr = Join-Path $runDirectory 'flutter.stderr.log'
  $combined = Join-Path $runDirectory 'flutter.log'
  $logcat = Join-Path $runDirectory 'logcat.log'
  $metadataPath = Join-Path $runDirectory 'metadata.json'

  $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
  $startOutput | Set-Content -LiteralPath (Join-Path $runDirectory 'emulator_start.log') -Encoding utf8
  if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
  $startOutput | Write-Output
  $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
  if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
  $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)
  Write-EveFitMetadata -Path $metadataPath -DeviceId $DeviceId

  if ($ClearAppData) {
    & (Join-Path $PSScriptRoot 'reset_evefit_test_device.ps1') -DeviceId $DeviceId -ClearAppData
    if ($LASTEXITCODE -ne 0) { throw 'The explicit app data reset failed.' }
  }

  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId)
  if ($LASTEXITCODE -ne 0) { throw 'Failed to stop the app before the Android smoke test.' }
  & $adb -s $DeviceId logcat -c
  if ($LASTEXITCODE -ne 0) { throw 'Failed to clear logcat before the Android smoke test.' }
  $logcatProcess = Start-Process -FilePath $adb -ArgumentList @('-s', $DeviceId, 'logcat') -RedirectStandardOutput $logcat -RedirectStandardError "$logcat.stderr.log" -PassThru -WindowStyle Hidden

  $command = 'call "{0}" test "integration_test/android_smoke_test.dart" -d {1} -r expanded --no-uninstall' -f $flutter, $DeviceId
  $result = Invoke-EveFitCommand -FilePath 'cmd.exe' -ArgumentList @('/d', '/c', $command) -WorkingDirectory $repository -StandardOutputPath $stdout -StandardErrorPath $stderr
  Get-Content -LiteralPath $stdout, $stderr | Set-Content -LiteralPath $combined -Encoding utf8
  Get-Content -LiteralPath $combined | Write-Output

  if ($result -ne 0) {
    $screenshots = Join-Path $runDirectory 'screenshots'
    New-Item -ItemType Directory -Force -Path $screenshots | Out-Null
    Save-AndroidSmokeAdbScreenshot -Adb $adb -TargetDevice $DeviceId -DestinationDirectory $screenshots | Out-Null
    throw "Android smoke Flutter test failed with exit code $result."
  }

  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId)
  if ($LASTEXITCODE -ne 0) { throw 'Failed to stop the app after the Android smoke test.' }
  $finalExitCode = 0
} catch {
  $failureMessage = $_.Exception.Message
  if ($null -ne $result) {
    $finalExitCode = [int]$result
  }
  if ($finalExitCode -eq 0) { $finalExitCode = 1 }
  Write-Error $_
} finally {
  if ($logcatProcess -and -not $logcatProcess.HasExited) {
    Stop-Process -Id $logcatProcess.Id -Force
    $logcatProcess.WaitForExit()
  }
  $started.Stop()

  if ($metadataPath) {
    $metadata = if (Test-Path -LiteralPath $metadataPath) {
      Get-Content -LiteralPath $metadataPath -Raw | ConvertFrom-Json
    } else {
      [pscustomobject]@{}
    }
    $metadata | Add-Member -NotePropertyName clear_app_data -NotePropertyValue ([bool]$ClearAppData) -Force
    $metadata | Add-Member -NotePropertyName duration_ms -NotePropertyValue $started.ElapsedMilliseconds -Force
    $metadata | Add-Member -NotePropertyName flutter_exit_code -NotePropertyValue $result -Force
    $metadata | Add-Member -NotePropertyName final_exit_code -NotePropertyValue $finalExitCode -Force
    $metadata | Add-Member -NotePropertyName outcome -NotePropertyValue $(if ($finalExitCode -eq 0) { 'passed' } else { 'failed' }) -Force
    $metadata | Add-Member -NotePropertyName failure -NotePropertyValue $failureMessage -Force
    $metadata | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $metadataPath -Encoding utf8
  }

  if ($runDirectory) {
    "ANDROID_SMOKE_RUN_DIRECTORY=$runDirectory"
    "ANDROID_SMOKE_LOG=$combined"
    "ANDROID_SMOKE_LOGCAT=$logcat"
    "ANDROID_SMOKE_METADATA=$metadataPath"
    "ANDROID_SMOKE_DURATION_MS=$($started.ElapsedMilliseconds)"
  }
  if ($gitState) {
    "BRANCH=$($gitState.Branch)"
    "COMMIT=$($gitState.Commit)"
  }
  if ($DeviceId) { "DEVICE_ID=$DeviceId" }
  "ANDROID_SMOKE_EXIT_CODE=$finalExitCode"
}

exit $finalExitCode
