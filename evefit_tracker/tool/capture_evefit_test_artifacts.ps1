[CmdletBinding()]
param(
  [string]$DeviceId,
  [string]$Scenario = 'dashboard'
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $adb = Get-EveFitAndroidTool 'adb'
  if (-not $DeviceId) { $DeviceId = Get-EveFitActiveDeviceId | Select-Object -First 1 }
  if (-not $DeviceId) { throw 'No running Android emulator was found.' }
  $packageId = Get-EveFitPackageId
  $timestamp = Get-EveFitTimestamp
  $artifactDirectory = Join-Path (Get-EveFitArtifactDirectory 'screenshots') "$timestamp`_$Scenario"
  New-Item -ItemType Directory -Force -Path $artifactDirectory | Out-Null
  $screenshot = Join-Path $artifactDirectory "$timestamp`_$Scenario.png"
  $logcat = Join-Path $artifactDirectory 'logcat.txt'

  $screencapCommand = '"{0}" -s {1} exec-out screencap -p > "{2}"' -f $adb, $DeviceId, $screenshot
  & cmd.exe /d /c $screencapCommand
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path $screenshot)) { throw 'ADB screenshot capture failed.' }
  & $adb -s $DeviceId logcat -d -t 1000 | Set-Content -LiteralPath $logcat -Encoding utf8
  & $adb -s $DeviceId shell dumpsys package $packageId | Set-Content -LiteralPath (Join-Path $artifactDirectory 'package.txt') -Encoding utf8
  Write-EveFitMetadata -Path (Join-Path $artifactDirectory 'metadata.json') -DeviceId $DeviceId
  "SCREENSHOT=$screenshot"
  "LOGCAT=$logcat"
  "METADATA=$(Join-Path $artifactDirectory 'metadata.json')"
  exit 0
} catch {
  Write-Error $_
  exit 1
}
