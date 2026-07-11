[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$AvdName = 'EveFit_Test_Device',
  [string]$Scenario = 'dashboard',
  [int]$BootTimeoutSeconds = 300
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $adb = Get-EveFitAndroidTool 'adb'
  if ($DeviceId) {
    $resolvedDevice = Get-EveFitActiveDeviceId -PreferredDeviceId $DeviceId
  } else {
    $resolvedDevice = Get-EveFitActiveDeviceId -AvdName $AvdName
  }
  if (-not $resolvedDevice) {
    $startOutput = & (Join-Path $PSScriptRoot 'start_evefit_emulator.ps1') -AvdName $AvdName -DeviceId $DeviceId -BootTimeoutSeconds $BootTimeoutSeconds
    if ($LASTEXITCODE -ne 0) { throw 'The emulator start script failed.' }
    $deviceLine = $startOutput | Where-Object { $_ -match '^DEVICE_ID=' } | Select-Object -Last 1
    if (-not $deviceLine) { throw 'The emulator start script did not return a device id.' }
    $resolvedDevice = $deviceLine.Substring('DEVICE_ID='.Length)
  }
  $DeviceId = $resolvedDevice
  Wait-EveFitAndroidBoot -DeviceId $DeviceId -TimeoutSeconds $BootTimeoutSeconds | Out-Null

  $packageId = Get-EveFitPackageId
  $runDirectory = New-EveFitRunDirectory 'captures' $Scenario
  $screenshot = Join-Path $runDirectory 'screenshot.png'
  $logcat = Join-Path $runDirectory 'logcat.log'
  $package = Join-Path $runDirectory 'package.txt'
  $metadata = Join-Path $runDirectory 'metadata.json'

  $screencapCommand = '"{0}" -s {1} exec-out screencap -p > "{2}"' -f $adb, $DeviceId, $screenshot
  & cmd.exe /d /c $screencapCommand
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path $screenshot) -or (Get-Item $screenshot).Length -eq 0) {
    throw 'ADB screenshot capture failed.'
  }
  & $adb -s $DeviceId logcat -d -t 1000 | Set-Content -LiteralPath $logcat -Encoding utf8
  & $adb -s $DeviceId shell dumpsys package $packageId | Set-Content -LiteralPath $package -Encoding utf8
  Write-EveFitMetadata -Path $metadata -DeviceId $DeviceId

  "DEVICE_ID=$DeviceId"
  "ARTIFACT_DIRECTORY=$runDirectory"
  "SCREENSHOT=$screenshot"
  "LOGCAT=$logcat"
  "PACKAGE_METADATA=$package"
  "METADATA=$metadata"
  exit 0
} catch {
  Write-Error $_
  exit 1
}
