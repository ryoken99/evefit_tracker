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

$logcatProcess = $null
try {
  $repository = Get-EveFitRepositoryRoot
  $gitState = Assert-EveFitGitExpectation -ExpectedBranch $ExpectedBranch -ExpectedCommit $ExpectedCommit
  $adb = Get-EveFitAndroidTool 'adb'
  $flutter = Get-EveFitFlutterTool

  $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
  if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
  $startOutput | Write-Output
  $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
  if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
  $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)

  if ($ClearAppData) {
    & (Join-Path $PSScriptRoot 'reset_evefit_test_device.ps1') -DeviceId $DeviceId -ClearAppData
    if ($LASTEXITCODE -ne 0) { throw 'The explicit app data reset failed.' }
  }

  & $adb -s $DeviceId shell am force-stop (Get-EveFitPackageId)
  if ($LASTEXITCODE -ne 0) { throw 'Failed to stop the app before the canonical core test.' }

  $timestamp = Get-EveFitTimestamp
  $runDirectory = Join-Path $repository "test_artifacts\canonical_core\full_app\$timestamp"
  $screenshotDirectory = Join-Path $runDirectory 'screenshots'
  New-Item -ItemType Directory -Force -Path $screenshotDirectory | Out-Null
  $stdout = Join-Path $runDirectory 'flutter_drive.stdout.log'
  $stderr = Join-Path $runDirectory 'flutter_drive.stderr.log'
  $combined = Join-Path $runDirectory 'flutter_drive.log'
  $logcat = Join-Path $runDirectory 'logcat.log'
  $metadata = Join-Path $runDirectory 'metadata.json'
  Write-EveFitMetadata -Path $metadata -DeviceId $DeviceId

  & $adb -s $DeviceId logcat -c
  if ($LASTEXITCODE -ne 0) { throw 'Failed to clear logcat before the canonical core test.' }
  $logcatProcess = Start-Process -FilePath $adb -ArgumentList @('-s', $DeviceId, 'logcat') -RedirectStandardOutput $logcat -RedirectStandardError "$logcat.stderr.log" -PassThru -WindowStyle Hidden

  $previousScreenshotDir = $env:EVEFIT_SCREENSHOT_DIR
  $previousScreenshotPrefix = $env:EVEFIT_SCREENSHOT_PREFIX
  try {
    $env:EVEFIT_SCREENSHOT_DIR = $screenshotDirectory
    $env:EVEFIT_SCREENSHOT_PREFIX = $timestamp
    $command = 'call "{0}" drive --driver "test_driver/integration_test.dart" --target "integration_test/canonical_core_search_full_app_test.dart" -d {1}' -f $flutter, $DeviceId
    $result = Invoke-EveFitCommand -FilePath 'cmd.exe' -ArgumentList @('/d', '/c', $command) -WorkingDirectory $repository -StandardOutputPath $stdout -StandardErrorPath $stderr
  } finally {
    if ($logcatProcess -and -not $logcatProcess.HasExited) {
      Stop-Process -Id $logcatProcess.Id -Force
      $logcatProcess.WaitForExit()
    }
    $env:EVEFIT_SCREENSHOT_DIR = $previousScreenshotDir
    $env:EVEFIT_SCREENSHOT_PREFIX = $previousScreenshotPrefix
  }

  Get-Content -LiteralPath $stdout, $stderr | Set-Content -LiteralPath $combined -Encoding utf8
  Get-Content -LiteralPath $combined | Write-Output
  "BRANCH=$($gitState.Branch)"
  "COMMIT=$($gitState.Commit)"
  "DEVICE_ID=$DeviceId"
  "FULL_APP_RUN_DIRECTORY=$runDirectory"
  "FULL_APP_LOG=$combined"
  "LOGCAT=$logcat"
  "SCREENSHOT_DIRECTORY=$screenshotDirectory"
  "METADATA=$metadata"
  "FULL_APP_EXIT_CODE=$result"
  exit $result
} catch {
  if ($logcatProcess -and -not $logcatProcess.HasExited) {
    Stop-Process -Id $logcatProcess.Id -Force
  }
  Write-Error $_
  exit 1
}
