#!/bin/sh
# Linux / WSL / devcontainer entry point.
# VS Code's "dotfiles" feature clones this repo and runs this script automatically.
#
#   ./install.sh          apply dotfiles
#   ./install.sh --chsh   also make zsh the login shell
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BIN_DIR="$HOME/.local/bin"

for cmd in git curl; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Missing required command: $cmd"; exit 1; }
done
command -v zsh >/dev/null 2>&1 || echo "Warning: zsh not installed; the shell config will be applied but not used."

if ! command -v chezmoi >/dev/null 2>&1; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
  export PATH="$BIN_DIR:$PATH"
fi

# Use this checkout as the chezmoi source, then apply it.
chezmoi init --apply --source="$SCRIPT_DIR"

if [ "${1:-}" = "--chsh" ]; then
  ZSH_PATH=$(command -v zsh)
  sudo chsh -s "$ZSH_PATH" "$USER"
  echo "Default shell updated to $ZSH_PATH"
fi

echo "Dotfiles applied. Start a new shell (exec zsh) to load changes."
