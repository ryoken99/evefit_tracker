[CmdletBinding()]
param(
  [string]$AvdName = 'EveFit_Test_Device',
  [string]$DeviceId,
  [int]$BootTimeoutSeconds = 300
)

. (Join-Path $PSScriptRoot 'evefit_android_test_helpers.ps1')

try {
  $adb = Get-EveFitAndroidTool 'adb'
  $emulator = Get-EveFitAndroidTool 'emulator'
  $runDirectory = New-EveFitRunDirectory 'emulator_start' $AvdName
  $stdout = Join-Path $runDirectory 'emulator.stdout.log'
  $stderr = Join-Path $runDirectory 'emulator.stderr.log'

  $resolvedDevice = Get-EveFitActiveDeviceId -PreferredDeviceId $DeviceId -AvdName $AvdName
  if (-not $resolvedDevice) {
    $resolvedDevice = Get-EveFitActiveDeviceId -AvdName $AvdName
  }

  if (-not $resolvedDevice) {
    if ($AvdName -notin (Get-EveFitAvdNames)) {
      throw "AVD '$AvdName' was not found. Available AVDs: $((Get-EveFitAvdNames) -join ', ')"
    }
    $process = Start-Process -FilePath $emulator -ArgumentList @('-avd', $AvdName, '-no-boot-anim') -RedirectStandardOutput $stdout -RedirectStandardError $stderr -PassThru -WindowStyle Hidden
    "EMULATOR_PID=$($process.Id)"

    $deadline = (Get-Date).AddSeconds($BootTimeoutSeconds)
    while (-not $resolvedDevice -and (Get-Date) -lt $deadline) {
      Start-Sleep -Seconds 2
      $resolvedDevice = Get-EveFitActiveDeviceId -AvdName $AvdName
    }
    if (-not $resolvedDevice) {
      throw "AVD '$AvdName' did not register with ADB within $BootTimeoutSeconds seconds."
    }
  }

  Wait-EveFitAndroidBoot -DeviceId $resolvedDevice -TimeoutSeconds $BootTimeoutSeconds | Out-Null
  $metadata = Join-Path $runDirectory 'metadata.json'
  Write-EveFitMetadata -Path $metadata -DeviceId $resolvedDevice
  "DEVICE_ID=$resolvedDevice"
  "AVD_NAME=$AvdName"
  "STARTUP_DIRECTORY=$runDirectory"
  "STARTUP_LOG=$stdout"
  "METADATA=$metadata"
  exit 0
} catch {
  Write-Error $_
  exit 1
}
