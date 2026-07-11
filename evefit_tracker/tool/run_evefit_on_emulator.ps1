[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [int]$BootTimeoutSeconds = 300,
  [string]$ExpectedBranch,
  [string]$ExpectedCommit,
  [switch]$ForcePubGet,
  [switch]$NoResident
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $repository = Get-EveFitRepositoryRoot
  $gitState = Assert-EveFitGitExpectation -ExpectedBranch $ExpectedBranch -ExpectedCommit $ExpectedCommit
  "BRANCH=$($gitState.Branch)"
  "COMMIT=$($gitState.Commit)"
  foreach ($line in $gitState.Status) { "GIT_STATUS=$line" }

  $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
  if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
  $startOutput | Write-Output
  $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
  if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
  $DeviceId = $deviceLine.Substring('DEVICE_ID='.Length)

  $flutter = Get-EveFitFlutterTool
  $runDirectory = New-EveFitRunDirectory 'runs' 'flutter_run'
  $log = Join-Path $runDirectory 'flutter_run.log'
  $packageConfig = Join-Path $repository '.dart_tool\package_config.json'
  $needsPubGet = $ForcePubGet -or -not (Test-Path $packageConfig)
  if ($needsPubGet) {
    Push-Location $repository
    try {
      & $flutter pub get 2>&1 | Tee-Object -FilePath $log
      if ($LASTEXITCODE -ne 0) { throw 'flutter pub get failed.' }
    } finally {
      Pop-Location
    }
  }

  "DEVICE_ID=$DeviceId"
  "PACKAGE_ID=$(Get-EveFitPackageId)"
  "FLUTTER_LOG=$log"
  Push-Location $repository
  try {
    $arguments = @('run', '-d', $DeviceId)
    if ($NoResident) { $arguments += '--no-resident' }
    & $flutter @arguments 2>&1 | Tee-Object -FilePath $log -Append
    $result = $LASTEXITCODE
  } finally {
    Pop-Location
  }
  exit $result
} catch {
  Write-Error $_
  exit 1
}
