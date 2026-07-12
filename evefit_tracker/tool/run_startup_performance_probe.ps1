[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [int]$BootTimeoutSeconds = 300,
  [string]$ExpectedBranch,
  [string]$ExpectedCommit,
  [ValidateSet('before', 'after')]
  [string]$Phase = 'after',
  [switch]$ExpectLegacyRuntime,
  [switch]$ClearAppData
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $repository = Get-EveFitRepositoryRoot
  $gitState = Assert-EveFitGitExpectation -ExpectedBranch $ExpectedBranch -ExpectedCommit $ExpectedCommit
  $adb = Get-EveFitAndroidTool 'adb'
  $flutter = Get-EveFitFlutterTool

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
  $runDirectory = Join-Path $repository "test_artifacts\startup_performance\$Phase\$timestamp"
  New-Item -ItemType Directory -Force -Path $runDirectory | Out-Null
  $stdout = Join-Path $runDirectory 'flutter_drive.stdout.log'
  $stderr = Join-Path $runDirectory 'flutter_drive.stderr.log'
  $combined = Join-Path $runDirectory 'flutter_drive.log'
  $metadata = Join-Path $runDirectory 'metadata.json'
  Write-EveFitMetadata -Path $metadata -DeviceId $DeviceId

  $legacyExpectation = if ($ExpectLegacyRuntime) { 'true' } else { 'false' }
  $command = 'call "{0}" drive --driver "test_driver/integration_test.dart" --target "integration_test/startup_performance_probe_test.dart" --dart-define=EVEFIT_EXPECT_LEGACY_RUNTIME={1} -d {2}' -f $flutter, $legacyExpectation, $DeviceId
  $result = Invoke-EveFitCommand -FilePath 'cmd.exe' -ArgumentList @('/d', '/c', $command) -WorkingDirectory $repository -StandardOutputPath $stdout -StandardErrorPath $stderr

  Get-Content -LiteralPath $stdout, $stderr | Set-Content -LiteralPath $combined -Encoding utf8
  $markers = Select-String -LiteralPath $combined -Pattern 'EVEFIT_(STARTUP_TO_USABLE_MS|DATABASE_OPEN_MS|LEGACY_SEED_DURATION_MS|LEGACY_SEED_INVOCATIONS|LEGACY_ENTRIES_PROCESSED)=' | ForEach-Object { $_.Line.Trim() }
  $markers | Write-Output
  "BRANCH=$($gitState.Branch)"
  "COMMIT=$($gitState.Commit)"
  "DEVICE_ID=$DeviceId"
  "STARTUP_PHASE=$Phase"
  "STARTUP_RUN_DIRECTORY=$runDirectory"
  "STARTUP_LOG=$combined"
  "METADATA=$metadata"
  "STARTUP_EXIT_CODE=$result"
  exit $result
} catch {
  Write-Error $_
  exit 1
}
