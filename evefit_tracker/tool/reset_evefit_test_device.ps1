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
  if (-not $DeviceId) { $DeviceId = Get-EveFitActiveDeviceId | Select-Object -First 1 }
  if (-not $DeviceId) { throw 'No running Android emulator was found.' }
  $packageId = Get-EveFitPackageId
  $artifactDirectory = Get-EveFitArtifactDirectory 'device'
  $log = Join-Path $artifactDirectory "$(Get-EveFitTimestamp)_reset.log"

  $state = (& $adb -s $DeviceId get-state 2>$null).Trim()
  if ($state -ne 'device') {
    throw "Android device '$DeviceId' is not available (state: $state). Start the emulator before resetting app data."
  }
  "DEVICE_STATE=$state" | Tee-Object -FilePath $log
  & $adb -s $DeviceId shell am force-stop $packageId | Tee-Object -FilePath $log -Append
  if ($UninstallApp) {
    & $adb -s $DeviceId uninstall $packageId | Tee-Object -FilePath $log -Append
  } elseif ($ClearAppData) {
    & $adb -s $DeviceId shell pm clear $packageId | Tee-Object -FilePath $log -Append
  } elseif (-not $ForceStopOnly) {
    'Default action is force-stop only. Use -ClearAppData or -UninstallApp for destructive app resets.' | Tee-Object -FilePath $log -Append
  }
  & $adb -s $DeviceId shell getprop sys.boot_completed | Tee-Object -FilePath $log -Append
  "DEVICE_ID=$DeviceId"
  "PACKAGE_ID=$packageId"
  "RESET_LOG=$log"
  exit 0
} catch {
  Write-Error $_
  exit 1
}
