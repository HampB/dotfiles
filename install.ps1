# Installs keyboard_layers.ahk to run at login and deploys the GlazeWM config.
#
# - The script is copied to %APPDATA%\keyboard_layers and started from a Startup
#   shortcut via AutoHotkey64_UIA.exe, so the layers also work in elevated
#   (admin) windows like Task Manager or an admin terminal.
# - glazewm/config.yaml is copied to ~/.glzr/glazewm/config.yaml (the old one is
#   backed up next to it as config.yaml.bak).

$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot

# --- AutoHotkey -------------------------------------------------------------
$ahkExe = "C:\Program Files\AutoHotkey\v2\AutoHotkey64_UIA.exe"
if (-not (Test-Path $ahkExe)) {
    throw "AutoHotkey v2 (UIA build) not found at $ahkExe"
}

$installDir = Join-Path $env:APPDATA "keyboard_layers"
New-Item -ItemType Directory -Force $installDir | Out-Null
$script = Join-Path $installDir "keyboard_layers.ahk"
Copy-Item (Join-Path $repo "keyboard_layers.ahk") $script -Force

$startup = [Environment]::GetFolderPath("Startup")

# The old setup copied the .ahk straight into Startup; remove it so it doesn't run twice.
$legacy = Join-Path $startup "keyboard_layers.ahk"
if (Test-Path $legacy) {
    Remove-Item $legacy
    Write-Host "Removed old Startup copy: $legacy"
}

$shortcutPath = Join-Path $startup "keyboard_layers.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $ahkExe
$shortcut.Arguments = "`"$script`""
$shortcut.WorkingDirectory = $installDir
$shortcut.Save()
Write-Host "Startup shortcut: $shortcutPath"

# --- GlazeWM ----------------------------------------------------------------
$glazeDir = Join-Path $env:USERPROFILE ".glzr\glazewm"
New-Item -ItemType Directory -Force $glazeDir | Out-Null
$glazeConfig = Join-Path $glazeDir "config.yaml"
if (Test-Path $glazeConfig) {
    Copy-Item $glazeConfig "$glazeConfig.bak" -Force
}
Copy-Item (Join-Path $repo "glazewm\config.yaml") $glazeConfig -Force
Write-Host "GlazeWM config: $glazeConfig (previous saved as config.yaml.bak)"

# --- (Re)start --------------------------------------------------------------
# Start the new script; #SingleInstance Force only replaces instances of the
# same file, so stop the old Startup-folder instance if it's still running.
Get-CimInstance Win32_Process -Filter "Name like 'AutoHotkey%'" |
    Where-Object { $_.CommandLine -like "*keyboard_layers.ahk*" } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
Start-Process $shortcutPath

if (Get-Process glazewm -ErrorAction SilentlyContinue) {
    & glazewm.exe command wm-reload-config
}

Write-Host "Done."
