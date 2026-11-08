# Windows entry point: installs chezmoi if needed and applies these dotfiles.
#
#   ./install.ps1

$ErrorActionPreference = "Stop"

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    winget install --id twpayne.chezmoi --exact --silent --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "User") + ";" + [Environment]::GetEnvironmentVariable("Path", "Machine")
}

# Use this checkout as the chezmoi source, then apply it.
chezmoi init --apply --source $PSScriptRoot
