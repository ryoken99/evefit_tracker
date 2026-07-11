[CmdletBinding()]
param(
  [string]$DeviceId,
  [switch]$ClearAppData,
  [switch]$UninstallApp,
  [switch]$ForceStopOnly
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  if ($ClearAppData -and $UninstallApp) {
    throw 'Use either -ClearAppData or -UninstallApp, not both.'
  }
  $adb = Get-EveFitAndroidTool 'adb'
  if (-not $DeviceId) { $DeviceId = Get-EveFitActiveDeviceId }
  if (-not $DeviceId) { throw 'No running Android emulator was found.' }
  Wait-EveFitAndroidBoot -DeviceId $DeviceId -TimeoutSeconds 60 | Out-Null

  $packageId = Get-EveFitPackageId
  $runDirectory = New-EveFitRunDirectory 'device' 'reset'
  $log = Join-Path $runDirectory 'reset.log'
  "DEVICE_ID=$DeviceId" | Tee-Object -FilePath $log
  "PACKAGE_ID=$packageId" | Tee-Object -FilePath $log -Append

  $packagePath = @(& $adb -s $DeviceId shell pm path $packageId 2>$null)
  $isInstalled = $LASTEXITCODE -eq 0 -and ($packagePath -match '^package:').Count -gt 0
  if ($isInstalled) {
    & $adb -s $DeviceId shell am force-stop $packageId 2>&1 | Tee-Object -FilePath $log -Append
    if ($LASTEXITCODE -ne 0) { throw 'App force-stop failed.' }
  } else {
    'APP_NOT_INSTALLED=true' | Tee-Object -FilePath $log -Append
  }

  if ($UninstallApp -and $isInstalled) {
    & $adb -s $DeviceId uninstall $packageId 2>&1 | Tee-Object -FilePath $log -Append
    if ($LASTEXITCODE -ne 0) { throw 'App uninstall failed.' }
  } elseif ($ClearAppData -and $isInstalled) {
    & $adb -s $DeviceId shell pm clear $packageId 2>&1 | Tee-Object -FilePath $log -Append
    if ($LASTEXITCODE -ne 0) { throw 'App data clear failed.' }
  } elseif (($ClearAppData -or $UninstallApp) -and -not $isInstalled) {
    'APP_DATA_ALREADY_ABSENT=true' | Tee-Object -FilePath $log -Append
  } elseif (-not $ForceStopOnly) {
    'Default action: force-stop only. Use -ClearAppData or -UninstallApp for explicit destructive app resets.' | Tee-Object -FilePath $log -Append
  }

  Wait-EveFitAndroidBoot -DeviceId $DeviceId -TimeoutSeconds 60 | Out-Null
  "RESET_LOG=$log"
  "EMULATOR_OPERATIONAL=true"
  exit 0
} catch {
  Write-Error $_
  exit 1
}
