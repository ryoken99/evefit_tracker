$ErrorActionPreference = "Stop"

function Invoke-Step {
  param(
    [Parameter(Mandatory = $true)]
    [string] $Command
  )

  Write-Host "==> $Command"
  Invoke-Expression $Command
  if ($LASTEXITCODE -ne 0) {
    throw "Command failed: $Command"
  }
}

Invoke-Step "flutter pub get"
Invoke-Step "flutter analyze"
Invoke-Step "flutter test -r compact"
Invoke-Step "dart run tool/catalog_audit_report.dart --strict"

