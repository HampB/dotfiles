#!/bin/zsh

# ensures $SHELL is also set to zsh
export SHELL=/bin/zsh

# adds home bin folder to path, if it already wasn't there
if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# adds local home bin folder to path, if it already wasn't there
if ! [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

PLUGINS_DIR="$HOME/.zsh_addons"
if [ ! -d $PLUGINS_DIR ]; then
    mkdir "$PLUGINS_DIR"
fi

# REALLY IMPORTANT FOR AUTOCOMPLETE
setopt interactivecomments

# Check if .aliases exists and sources it
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Check if .aliases.local exists and sources it
# this can be used to set aliases for your specific environment
[[ -f $HOME/.aliases.local ]] && source $HOME/.aliases.local

[ -f "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && source "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -f "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ] && source "$PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

if command -v gcloud &> /dev/null; then
    source /usr/lib/google-cloud-sdk/completion.bash.inc
fi

if command -v dbt &> /dev/null; then
    [ -f ~/.dbt-completion.bash ] && source ~/.dbt-completion.bash
    dbts() {
        dbt show --select "$1" --limit 1 --output json
    }
fi

# append new history entries to the history file
setopt APPEND_HISTORY

# save each command to the history file as soon as it is executed
setopt INC_APPEND_HISTORY

# ignore recording duplicate consecutive commands in the history
setopt HIST_IGNORE_DUPS

# ignore commands that start with a space in the history
setopt HIST_IGNORE_SPACE

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

if command -v gh &> /dev/null; then
    mkdir -p ~/.zsh/completions
    fpath+=~/.zsh/completions
    gh completion -s zsh > ~/.zsh/completions/_gh
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}

autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit

if [ -x "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" ]; then
    export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
elif command -v xdg-open >/dev/null 2>&1; then
    export BROWSER="$(command -v xdg-open)"
fi

# Starts zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Starts starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.npm-global/bin:$PATH"
