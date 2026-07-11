[CmdletBinding()]
param(
  [string]$DeviceId,
  [int]$BootTimeoutSeconds = 300,
  [switch]$ClearAppData
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $repository = Get-EveFitRepositoryRoot
  $adb = Get-EveFitAndroidTool 'adb'
  $expectedBranch = 'dashboard-rebuild-v1'
  $expectedCommit = 'e80b6155ec3c41ee3383fd9639872450ccac9fc8'
  if ((git -C $repository branch --show-current) -ne $expectedBranch) { throw "Expected branch $expectedBranch." }
  if ((git -C $repository rev-parse HEAD) -ne $expectedCommit) { throw "Expected commit $expectedCommit." }
  $allowedInfrastructureChanges = @(
    '.gitignore',
    'pubspec.yaml',
    'pubspec.lock',
    'evefit_tracker/.gitignore',
    'evefit_tracker/pubspec.yaml',
    'evefit_tracker/pubspec.lock',
    'lib/screens/dashboard_screen.dart',
    'lib/screens/profile_gate_screen.dart',
    'lib/widgets/dashboard_editor_sheet.dart',
    'evefit_tracker/lib/screens/dashboard_screen.dart',
    'evefit_tracker/lib/screens/profile_gate_screen.dart',
    'evefit_tracker/lib/widgets/dashboard_editor_sheet.dart'
  )
  $trackedChanges = git -C $repository diff --name-only | Where-Object { $_ -notin $allowedInfrastructureChanges }
  if ($trackedChanges) { throw "Tracked Git changes are present:`n$($trackedChanges -join "`n")" }
  if ($DeviceId -and ((& $adb -s $DeviceId get-state 2>$null).Trim() -ne 'device')) {
    $DeviceId = $null
  }
  if (-not $DeviceId) {
    $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -BootTimeoutSeconds $BootTimeoutSeconds
    $startOutput | Write-Output
    $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
    if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
    $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)
  }
  if ($ClearAppData) {
    & (Join-Path $PSScriptRoot 'reset_evefit_test_device.ps1') -DeviceId $DeviceId -ClearAppData
    if ($LASTEXITCODE -ne 0) { throw 'The explicit app data reset failed.' }
  }
  $flutter = Get-EveFitFlutterTool
  $timestamp = Get-EveFitTimestamp
  $artifactDirectory = Get-EveFitArtifactDirectory 'integration'
  $logDirectory = Get-EveFitArtifactDirectory 'logs'
  $screenshotDirectory = Join-Path (Get-EveFitArtifactDirectory 'screenshots') $timestamp
  New-Item -ItemType Directory -Force -Path $screenshotDirectory | Out-Null
  $log = Join-Path $logDirectory "$timestamp`_dashboard_integration.log"
  $stdout = "$log.stdout"
  $stderr = "$log.stderr"
  Push-Location $repository
  try {
    $env:EVEFIT_SCREENSHOT_DIR = $screenshotDirectory
    $env:EVEFIT_SCREENSHOT_PREFIX = $timestamp
    $command = 'call "{0}" drive --driver "test_driver/integration_test.dart" --target "integration_test/dashboard_rebuild_flow_test.dart" -d {1}' -f $flutter, $DeviceId
    $process = Start-Process -FilePath 'cmd.exe' -ArgumentList @('/d', '/c', $command) -WorkingDirectory $repository -RedirectStandardOutput $stdout -RedirectStandardError $stderr -PassThru -WindowStyle Hidden
    $process.WaitForExit()
    Get-Content -LiteralPath $stdout, $stderr | Tee-Object -FilePath $log
    $result = $process.ExitCode
  } finally {
    Pop-Location
  }
  "DEVICE_ID=$DeviceId"
  "INTEGRATION_LOG=$log"
  "SCREENSHOT_DIRECTORY=$screenshotDirectory"
  exit $result
} catch {
  Write-Error $_
  exit 1
}
