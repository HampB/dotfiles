# keyboard_layers

AutoHotkey v2 keyboard layers for a Swedish layout, plus the GlazeWM config they work with.

| Layer | Hold | Notes |
|---|---|---|
| Navigation | CapsLock (tap = Esc) | Arrows on `ijkl`, one-shot Ctrl/Shift/Alt/Win on `f`/`d`/`s`/`g`, see `layouts/navigation-layout.png` |
| Symbols | RAlt / AltGr | Brackets and operators on the home rows, see `layouts/symbol-layout.png` |

Window management (Alt + `ijkl`, workspaces, resize, etc.) is handled natively by
GlazeWM via `glazewm/config.yaml`. The AHK script only adds the layers and the
Alt+Enter (WSL) / Alt+Shift+Enter (PowerShell) launchers.

## Install

```powershell
./install.ps1
```

This copies the script to `%APPDATA%\keyboard_layers`, adds a Startup shortcut that
runs it with `AutoHotkey64_UIA.exe` (so the layers also work in admin windows),
deploys the GlazeWM config (backing up the old one) and restarts both.

## Files

- `keyboard_layers.ahk`: the layers
- `glazewm/config.yaml`: GlazeWM config including keybindings
- `install.ps1`: installer
- `layouts/`: layer diagrams (keyboard-layout-editor.com JSON + PNG)
