# WSL Dotfiles

Personal shell and terminal setup for WSL and devcontainers.

This repo manages:
- zsh shell config
- aliases
- starship prompt config
- lf file manager config
- zsh plugins and terminal tooling bootstrapping

Based on ideas from:
https://github.com/matheusfvesco/devcontainers-dotfiles

## Repository layout

- .zshrc
- .aliases
- .config/starship.toml
- .config/lf/lfrc
- install.sh

## Prerequisites (WSL)

Install baseline packages first:

```bash
sudo apt-get update
sudo apt-get install -y zsh git curl wget unzip
```

## Installation

Clone and run the installer:

```bash
git clone https://github.com/HampB/devcontainer-dotfiles.git ~/devcontainer-dotfiles
cd ~/devcontainer-dotfiles
chmod +x install.sh
./install.sh
```

Optional: also set zsh as your default login shell:

```bash
./install.sh --chsh
```

## What the installer does

- Symlinks this repo's dotfiles into your home directory
- Creates required config directories
- Installs or updates zsh plugins under ~/.zsh_addons
- Installs fzf extras
- Installs zip/unzip and ripgrep when apt is available
- Downloads Hack Nerd Font into ~/.local/share/fonts
- Installs zoxide, lf, and starship
- Installs dbt shell completion script to ~/.dbt-completion.bash

## Re-running safely

The installer is designed to be re-runnable:
- existing symlinks are replaced
- plugin repositories are updated when already present
- missing directories are re-created

## Post-install

Start a new shell session, or run:

```bash
exec zsh
```

## Notes

- Keep machine-specific aliases in ~/.aliases.local so updates to this repo stay clean.
- If running in a minimal container without sudo, install required packages manually and then run ./install.sh.