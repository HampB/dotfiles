# dotfiles

Personal config for Windows, Linux/WSL and devcontainers, managed with [chezmoi](https://chezmoi.io).

Replaces [devcontainer-dotfiles](https://github.com/HampB/devcontainer-dotfiles) and
[keyboard_layers](https://github.com/HampB/keyboard_layers); both histories are merged in here.

## What's where

| | Windows | Linux / WSL / devcontainer |
|---|---|---|
| Prompt: starship (`dot_config/starship.toml`) | ✓ | ✓ |
| Git: aliases + defaults (`dot_config/git/config`) | ✓ | ✓ |
| Shell: zsh, aliases, plugins, lf | | ✓ |
| Keyboard layers: AutoHotkey (`AppData/Roaming/keyboard_layers`) | ✓ | |
| Tiling WM: GlazeWM (`dot_glzr/glazewm`) | ✓ | |
| Status bar: Zebar (`dot_glzr/zebar`) | ✓ | |

Everything chezmoi manages lives under [`home/`](home), using chezmoi's naming (`dot_zshrc` → `~/.zshrc`).
Per-OS selection is in [`home/.chezmoiignore`](home/.chezmoiignore); setup steps are in
[`home/.chezmoiscripts`](home/.chezmoiscripts) and re-run automatically when they (or the file they deploy) change.

## Install

**Windows** (PowerShell):

```powershell
git clone https://github.com/HampB/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles; ./install.ps1
```

Installs chezmoi, AutoHotkey, GlazeWM, Zebar and starship via winget, applies the configs, sets the keyboard
layers to start at login (via `AutoHotkey64_UIA.exe`, so they work in admin windows) and reloads GlazeWM.
`gat-gwm` is installed with cargo if Rust is available.

**Linux / WSL**:

```bash
git clone https://github.com/HampB/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh          # add --chsh to make zsh the login shell
```

**Devcontainers**: in VS Code settings set

```json
"dotfiles.repository": "HampB/dotfiles"
```

VS Code clones the repo and runs `install.sh` in every new container.

## Day to day

```sh
chezmoi edit ~/.zshrc     # edit the source file, then:
chezmoi apply             # deploy (also re-runs any changed setup script)
chezmoi diff              # what apply would change
chezmoi re-add            # pull changes made directly in ~ back into the repo
chezmoi cd                # jump to the repo to commit/push
```

Machine-specific aliases go in `~/.aliases.local` (not tracked).

## Git

Shared settings and aliases live in `~/.config/git/config`, which git reads alongside
`~/.gitconfig`. Your identity stays in the untracked `~/.gitconfig` on each machine:

```sh
git config --global user.name  "HampB"
git config --global user.email "you@example.com"
```

Aliases: `git st`, `ss`, `pl`, `ps`, `nb`, `c`, `ca`, `a`, `aa`, `sw`, `swm`, `lg`. These are the same shortcuts
as the zsh `gs`/`gaa`/… aliases, but they also work in PowerShell.

## Secrets

This repo is **public**. Several things guard against leaking a secret:

- `chezmoi add` refuses files that look like they contain secrets (`add.secrets = "error"`).
- `.gitignore` blocks common secret files (`.env`, keys, `.git-credentials`, …).
- GitHub push protection rejects pushes that contain known token formats.
- A gitleaks workflow scans every push for generic secrets too.

To track a file that *does* contain a secret, encrypt it with [age](https://chezmoi.io/user-guide/encryption/age/):

```sh
chezmoi age-keygen --output ~/.config/chezmoi/key.txt   # once; prints the public key
```

Add this to `home/.chezmoi.toml.tmpl` (public key only; the private key never goes in the repo):

```toml
encryption = "age"
[age]
    identity  = "~/.config/chezmoi/key.txt"
    recipient = "age1..."
```

Then use `chezmoi add --encrypt <file>`. Copy `key.txt` to each machine through a safe channel,
such as a password manager. For a single token, chezmoi can also read it straight from a password manager in a template
(`{{ onepassword ... }}`, `{{ bitwarden ... }}`, …) instead of storing it at all.

## Keyboard layers

| Layer | Hold | Notes |
|---|---|---|
| Navigation | CapsLock (tap = Esc) | Arrows on `ijkl`, one-shot Ctrl/Shift/Alt/Win on `f`/`d`/`s`/`g` ([diagram](docs/layouts/navigation-layout.png)) |
| Symbols | RAlt / AltGr | Brackets and operators on the home rows ([diagram](docs/layouts/symbol-layout.png)) |

Window management (Alt + `ijkl`, workspaces, resize, …) is handled natively by GlazeWM. The AHK script only adds
the layers and the Alt+Enter (WSL) / Alt+Shift+Enter (PowerShell) launchers.
