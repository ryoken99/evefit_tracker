[CmdletBinding()]
param(
  [string]$AvdName = 'EveFit_Test_Device',
  [int]$BootTimeoutSeconds = 300
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $adb = Get-EveFitAndroidTool 'adb'
  $emulator = Get-EveFitAndroidTool 'emulator'
  $artifactDirectory = Get-EveFitArtifactDirectory 'emulator_start'
  $timestamp = Get-EveFitTimestamp
  $log = Join-Path $artifactDirectory "$timestamp`_emulator.log"

  $deviceId = $null
  foreach ($candidate in Get-EveFitActiveDeviceId) {
    $name = (& $adb -s $candidate emu avd name 2>$null).Trim()
    if ($name -eq $AvdName) {
      $deviceId = $candidate
      break
    }
  }

  if (-not $deviceId) {
    $available = & $emulator -list-avds
    if ($available -notcontains $AvdName) {
      throw "AVD '$AvdName' was not found. Create it with avdmanager before starting the emulator."
    }
    $process = Start-Process -FilePath $emulator -ArgumentList @('-avd', $AvdName, '-no-boot-anim') -RedirectStandardOutput $log -RedirectStandardError "$log.stderr" -PassThru -WindowStyle Hidden
    "EMULATOR_PID=$($process.Id)"
  }

  $deadline = (Get-Date).AddSeconds($BootTimeoutSeconds)
  while ((Get-Date) -lt $deadline) {
    foreach ($candidate in Get-EveFitActiveDeviceId) {
      $name = (& $adb -s $candidate emu avd name 2>$null).Trim()
      if ($name -eq $AvdName) {
        $booted = (& $adb -s $candidate shell getprop sys.boot_completed 2>$null).Trim()
        if ($booted -eq '1') {
          & $adb -s $candidate shell pm list packages | Out-Null
          "DEVICE_ID=$candidate"
          "STARTUP_LOG=$log"
          exit 0
        }
      }
    }
    Start-Sleep -Seconds 3
  }
  throw "Emulator '$AvdName' did not complete boot within $BootTimeoutSeconds seconds. See $log."
} catch {
  Write-Error $_
  exit 1
}
