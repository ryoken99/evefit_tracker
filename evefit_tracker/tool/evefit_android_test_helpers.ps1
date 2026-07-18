Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (Test-Path variable:PSNativeCommandUseErrorActionPreference) {
  $PSNativeCommandUseErrorActionPreference = $false
}

function Get-EveFitRepositoryRoot {
  return (Split-Path -Parent $PSScriptRoot)
}

function Get-EveFitAndroidSdkRoot {
  $candidates = @(@(
      $env:ANDROID_SDK_ROOT,
      $env:ANDROID_HOME,
      (Join-Path $env:LOCALAPPDATA 'Android\Sdk'),
      'C:\tools\android-sdk'
    ) | Where-Object { $_ -and (Test-Path (Join-Path $_ 'platform-tools')) })

  if ($candidates.Count -eq 0) {
    throw 'Android SDK was not found. Set ANDROID_SDK_ROOT or ANDROID_HOME, or install the SDK in the standard local path.'
  }

  return (Resolve-Path $candidates[0]).Path
}

function Get-EveFitAndroidTool([string]$Name) {
  $sdkRoot = Get-EveFitAndroidSdkRoot
  $path = switch ($Name) {
    'adb' { Join-Path $sdkRoot 'platform-tools\adb.exe' }
    'emulator' { Join-Path $sdkRoot 'emulator\emulator.exe' }
    'sdkmanager' { Join-Path $sdkRoot 'cmdline-tools\latest\bin\sdkmanager.bat' }
    'avdmanager' { Join-Path $sdkRoot 'cmdline-tools\latest\bin\avdmanager.bat' }
    default { throw "Unsupported Android tool: $Name" }
  }

  if (Test-Path $path) { return (Resolve-Path $path).Path }
  $commandName = if ($Name -in @('sdkmanager', 'avdmanager')) { "$Name.bat" } else { "$Name.exe" }
  $command = Get-Command $commandName -ErrorAction SilentlyContinue
  if ($command) { return $command.Source }
  throw "Android tool '$Name' was not found below $sdkRoot or on PATH."
}

function Get-EveFitFlutterTool {
  $command = Get-Command flutter.bat -ErrorAction SilentlyContinue
  if ($command) { return $command.Source }

  $fallbacks = @(
    (Join-Path $env:USERPROFILE 'development\flutter\bin\flutter.bat'),
    'C:\tools\flutter\bin\flutter.bat',
    'C:\src\flutter\bin\flutter.bat'
  )
  foreach ($fallback in $fallbacks) {
    if (Test-Path $fallback) { return (Resolve-Path $fallback).Path }
  }
  throw 'Flutter was not found on PATH or in a supported local installation path.'
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

function Get-EveFitTimestamp {
  return (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHHmmssZ')
}

function Get-EveFitArtifactDirectory([string]$Category) {
  $root = Join-Path (Get-EveFitRepositoryRoot) 'test_artifacts\dashboard'
  $path = Join-Path $root $Category
  New-Item -ItemType Directory -Force -Path $path | Out-Null
  return $path
}

function New-EveFitRunDirectory([string]$Category, [string]$Suffix = '') {
  $parent = Get-EveFitArtifactDirectory $Category
  $name = Get-EveFitTimestamp
  if ($Suffix) { $name = "$name`_$Suffix" }
  $path = Join-Path $parent $name
  $counter = 1
  while (Test-Path $path) {
    $path = Join-Path $parent "$name`_$counter"
    $counter++
  }
  New-Item -ItemType Directory -Path $path | Out-Null
  return $path
}

function Get-EveFitAvdNames {
  $emulator = Get-EveFitAndroidTool 'emulator'
  return @(& $emulator -list-avds | Where-Object { $_ -and $_.Trim() } | ForEach-Object { $_.Trim() })
}

function Get-EveFitActiveDeviceId(
  [string]$PreferredDeviceId,
  [string]$AvdName
) {
  $adb = Get-EveFitAndroidTool 'adb'
  $devices = @(& $adb devices | Select-Object -Skip 1 | ForEach-Object {
    $parts = $_.Trim() -split '\s+'
    if ($parts.Count -ge 2 -and $parts[1] -eq 'device' -and $parts[0] -like 'emulator-*') {
      $parts[0]
    }
  })

  if ($PreferredDeviceId) {
    if ($PreferredDeviceId -in $devices) { return $PreferredDeviceId }
    return $null
  }

  foreach ($device in $devices) {
    if (-not $AvdName) { return $device }
    $activeAvd = (& $adb -s $device emu avd name 2>$null | Select-Object -First 1).Trim()
    if ($activeAvd -eq $AvdName) { return $device }
  }
  return $null
}

function Wait-EveFitAndroidBoot([string]$DeviceId, [int]$TimeoutSeconds = 300) {
  $adb = Get-EveFitAndroidTool 'adb'
  $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
  while ((Get-Date) -lt $deadline) {
    $state = (& $adb -s $DeviceId get-state 2>$null).Trim()
    if ($state -eq 'device') {
      $booted = (& $adb -s $DeviceId shell getprop sys.boot_completed 2>$null).Trim()
      if ($booted -eq '1') {
        & $adb -s $DeviceId shell pm list packages | Out-Null
        if ($LASTEXITCODE -eq 0) { return $DeviceId }
      }
    }
    Start-Sleep -Seconds 3
  }
  throw "Android device '$DeviceId' did not complete boot within $TimeoutSeconds seconds."
}

function Assert-EveFitGitExpectation([string]$ExpectedBranch, [string]$ExpectedCommit) {
  $repository = Get-EveFitRepositoryRoot
  $branch = (git -C $repository branch --show-current).Trim()
  $commit = (git -C $repository rev-parse HEAD).Trim()
  if ($ExpectedBranch -and $branch -ne $ExpectedBranch) {
    throw "Expected Git branch '$ExpectedBranch', found '$branch'."
  }
  if ($ExpectedCommit -and -not $commit.StartsWith($ExpectedCommit, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Expected Git commit '$ExpectedCommit', found '$commit'."
  }
  return [pscustomobject]@{
    Branch = $branch
    Commit = $commit
    Status = @(git -C $repository status --short)
  }
}

function Invoke-EveFitCommand(
  [string]$FilePath,
  [string[]]$ArgumentList,
  [string]$WorkingDirectory,
  [string]$StandardOutputPath,
  [string]$StandardErrorPath
) {
  $arguments = @($ArgumentList)
  $isCmd = [System.IO.Path]::GetFileName($FilePath) -ieq 'cmd.exe'
  if (-not $isCmd) {
    throw "Invoke-EveFitCommand currently requires cmd.exe, found '$FilePath'."
  }
  $commandIndex = [Array]::IndexOf($arguments, '/c') + 1
  if ($commandIndex -le 0 -or $commandIndex -ge $arguments.Count) {
    throw 'Invoke-EveFitCommand requires a cmd.exe /c command.'
  }
  $arguments[$commandIndex] = '{0} 1> "{1}" 2> "{2}"' -f $arguments[$commandIndex], $StandardOutputPath, $StandardErrorPath
  $process = Start-Process -FilePath $FilePath -ArgumentList $arguments -WorkingDirectory $WorkingDirectory -PassThru -WindowStyle Hidden
  # Wait only for the requested command, not long-lived descendants such as
  # the Gradle daemon that may outlive a completed Flutter invocation.
  $process.WaitForExit()
  $process.Refresh()
  $exitCode = $process.ExitCode
  if ($null -eq $exitCode) {
    throw "Command '$FilePath' completed without an exit code."
  }
  return [int]$exitCode
}

function Write-EveFitMetadata([string]$Path, [string]$DeviceId) {
  $adb = Get-EveFitAndroidTool 'adb'
  $gitState = Assert-EveFitGitExpectation
  $metadata = [ordered]@{
    timestamp_utc = (Get-Date).ToUniversalTime().ToString('o')
    repository = Get-EveFitRepositoryRoot
    branch = $gitState.Branch
    commit = $gitState.Commit
    git_status = $gitState.Status
    package_id = Get-EveFitPackageId
    device_id = $DeviceId
    avd_name = ((& $adb -s $DeviceId emu avd name 2>$null | Select-Object -First 1).Trim())
    device_model = ((& $adb -s $DeviceId shell getprop ro.product.model).Trim())
    android_version = ((& $adb -s $DeviceId shell getprop ro.build.version.release).Trim())
    api_level = ((& $adb -s $DeviceId shell getprop ro.build.version.sdk).Trim())
    abi = ((& $adb -s $DeviceId shell getprop ro.product.cpu.abi).Trim())
  }
  $metadata | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $Path -Encoding utf8
}
