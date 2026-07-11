Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-EveFitRepositoryRoot {
  return (Split-Path -Parent $PSScriptRoot)
}

function Get-EveFitAndroidSdkRoot {
  $candidates = @(@(
    $env:ANDROID_SDK_ROOT,
    $env:ANDROID_HOME,
    'C:\tools\android-sdk'
  ) | Where-Object { $_ -and (Test-Path $_) })

  if ($candidates.Count -eq 0) {
    throw 'Android SDK was not found. Set ANDROID_SDK_ROOT or install it at C:\tools\android-sdk.'
  }

  return (Resolve-Path $candidates[0]).Path
}

function Get-EveFitAndroidTool([string]$Name) {
  $sdkRoot = Get-EveFitAndroidSdkRoot
  $paths = switch ($Name) {
    'adb' { @((Join-Path $sdkRoot 'platform-tools\adb.exe')) }
    'emulator' { @((Join-Path $sdkRoot 'emulator\emulator.exe')) }
    'sdkmanager' { @((Join-Path $sdkRoot 'cmdline-tools\latest\bin\sdkmanager.bat')) }
    'avdmanager' { @((Join-Path $sdkRoot 'cmdline-tools\latest\bin\avdmanager.bat')) }
    default { throw "Unsupported Android tool: $Name" }
  }

  foreach ($path in $paths) {
    if (Test-Path $path) { return (Resolve-Path $path).Path }
  }
  throw "Android tool '$Name' was not found below $sdkRoot."
}

function Get-EveFitFlutterTool {
  $command = Get-Command flutter.bat -ErrorAction SilentlyContinue
  if ($command) { return $command.Source }
  $fallback = 'C:\Users\utilizador\development\flutter\bin\flutter.bat'
  if (Test-Path $fallback) { return $fallback }
  throw 'Flutter was not found. Add Flutter to PATH or install it at C:\Users\utilizador\development\flutter.'
}

function Get-EveFitPackageId {
  $buildFile = Join-Path (Get-EveFitRepositoryRoot) 'android\app\build.gradle.kts'
  if (-not (Test-Path $buildFile)) {
    throw "Android build file was not found: $buildFile"
  }

  $match = Select-String -LiteralPath $buildFile -Pattern 'applicationId\s*=\s*"([^"]+)"' | Select-Object -First 1
  if (-not $match) {
    throw "applicationId was not found in $buildFile"
  }
  return $match.Matches[0].Groups[1].Value
}

function Get-EveFitArtifactDirectory([string]$Category) {
  $root = Join-Path (Get-EveFitRepositoryRoot) 'test_artifacts\dashboard'
  $path = Join-Path $root $Category
  New-Item -ItemType Directory -Force -Path $path | Out-Null
  return $path
}

function Get-EveFitTimestamp {
  return (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHHmmssZ')
}

function Get-EveFitActiveDeviceId {
  $adb = Get-EveFitAndroidTool 'adb'
  $devices = & $adb devices | Select-Object -Skip 1 | ForEach-Object {
    $parts = $_ -split '\s+'
    if ($parts.Count -ge 2 -and $parts[1] -eq 'device') { $parts[0] }
  }
  return @($devices | Where-Object { $_ -like 'emulator-*' } | Select-Object -First 1)
}

function Write-EveFitMetadata([string]$Path, [string]$DeviceId) {
  $adb = Get-EveFitAndroidTool 'adb'
  $repository = Get-EveFitRepositoryRoot
  $metadata = [ordered]@{
    timestamp_utc = (Get-Date).ToUniversalTime().ToString('o')
    branch = (git -C $repository branch --show-current)
    commit = (git -C $repository rev-parse HEAD)
    package_id = Get-EveFitPackageId
    device_id = $DeviceId
    android_version = (& $adb -s $DeviceId shell getprop ro.build.version.release).Trim()
    api_level = (& $adb -s $DeviceId shell getprop ro.build.version.sdk).Trim()
  }
  $metadata | ConvertTo-Json | Set-Content -LiteralPath $Path -Encoding utf8
}
