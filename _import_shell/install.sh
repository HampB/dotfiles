#!/bin/sh

set -eu

PLUGINS_DIR="$HOME/.zsh_addons"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

ensure_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1"
    exit 1
  fi
}

link_file() {
  src="$1"
  dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -f "$dest"
  ln -s "$src" "$dest"
}

clone_or_update() {
  repo="$1"
  target="$2"

  if [ -d "$target/.git" ]; then
    git -C "$target" pull --ff-only >/dev/null 2>&1 || true
  else
    rm -rf "$target"
    git clone --depth 1 "$repo" "$target"
  fi
}

ensure_cmd zsh
ensure_cmd git
ensure_cmd curl

mkdir -p "$HOME/.config/lf" "$PLUGINS_DIR" "$HOME/.local/share/fonts"

link_file "$SCRIPT_DIR/.aliases" "$HOME/.aliases"
link_file "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
link_file "$SCRIPT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
link_file "$SCRIPT_DIR/.config/lf/lfrc" "$HOME/.config/lf/lfrc"

clone_or_update "https://github.com/zsh-users/zsh-autosuggestions" "$PLUGINS_DIR/zsh-autosuggestions"
clone_or_update "https://github.com/marlonrichert/zsh-autocomplete.git" "$PLUGINS_DIR/zsh-autocomplete"
clone_or_update "https://github.com/zdharma-continuum/fast-syntax-highlighting" "$PLUGINS_DIR/fast-syntax-highlighting"
clone_or_update "https://github.com/junegunn/fzf.git" "$PLUGINS_DIR/fzf"

if [ -x "$PLUGINS_DIR/fzf/install" ]; then
  "$PLUGINS_DIR/fzf/install" --all --no-bash --no-fish
fi

if command -v apt-get >/dev/null 2>&1; then
  APT_PREFIX=""
  if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
      APT_PREFIX="sudo"
    else
      echo "Skipping apt install (not root and sudo is unavailable)."
    fi
  fi

  if [ "$(id -u)" -eq 0 ] || [ -n "$APT_PREFIX" ]; then
    $APT_PREFIX apt-get update -y
    $APT_PREFIX apt-get install -y zip unzip ripgrep
  fi
fi

if command -v wget >/dev/null 2>&1 && command -v unzip >/dev/null 2>&1; then
  tmp_zip="$(mktemp /tmp/hack-nerd-font.XXXXXX.zip)"
  wget -qO "$tmp_zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
  unzip -o "$tmp_zip" -d "$HOME/.local/share/fonts" >/dev/null
  rm -f "$tmp_zip"
fi

curl -sSfL "https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh" | sh
curl -sS "https://webi.sh/lf" | sh
curl -sS "https://starship.rs/install.sh" | sh -s -- -y

curl -fsSL "https://raw.githubusercontent.com/fishtown-analytics/dbt-completion.bash/master/dbt-completion.bash" -o "$HOME/.dbt-completion.bash"

if [ "${1:-}" = "--chsh" ]; then
  ZSH_PATH=$(command -v zsh)
  if command -v chsh >/dev/null 2>&1; then
    sudo chsh -s "$ZSH_PATH" "$USER"
    echo "Default shell updated to $ZSH_PATH"
  else
    echo "chsh not available, skipping default shell change."
  fi
else
  echo "Skipped default shell change. Re-run with --chsh to enable it."
fi

echo "Dotfiles install complete. Start a new shell session to load changes."