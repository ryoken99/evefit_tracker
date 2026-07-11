[CmdletBinding()]
param(
  [string]$DeviceId,
  [int]$BootTimeoutSeconds = 300,
  [switch]$NoResident
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $repository = Get-EveFitRepositoryRoot
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
    'evefit_tracker/pubspec.lock'
  )
  $trackedChanges = git -C $repository diff --name-only | Where-Object { $_ -notin $allowedInfrastructureChanges }
  if ($trackedChanges) { throw "Tracked Git changes are present:`n$($trackedChanges -join "`n")" }

  if (-not $DeviceId) {
    $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -BootTimeoutSeconds $BootTimeoutSeconds
    $startOutput | Write-Output
    $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
    if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
    $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)
  }

  $flutter = Get-EveFitFlutterTool
  $artifactDirectory = Get-EveFitArtifactDirectory 'runs'
  $log = Join-Path $artifactDirectory "$(Get-EveFitTimestamp)_flutter_run.log"
  if (-not (Test-Path (Join-Path $repository '.dart_tool\package_config.json'))) {
    & $flutter pub get | Tee-Object -FilePath $log
    if ($LASTEXITCODE -ne 0) { throw 'flutter pub get failed.' }
  }

  "DEVICE_ID=$DeviceId"
  "PACKAGE_ID=$(Get-EveFitPackageId)"
  "FLUTTER_LOG=$log"
  Push-Location $repository
  try {
    $arguments = @('run', '-d', $DeviceId)
    if ($NoResident) { $arguments += '--no-resident' }
    & $flutter @arguments 2>&1 | Tee-Object -FilePath $log -Append
    exit $LASTEXITCODE
  } finally {
    Pop-Location
  }
} catch {
  Write-Error $_
  exit 1
}
