#!/bin/zsh

# ensures $SHELL is also set to zsh
export SHELL=/bin/zsh

# adds home bin folder to path, if it already wasn't there
if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
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

source $PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh
if command -v gcloud &> /dev/null; then
    source /usr/lib/google-cloud-sdk/completion.bash.inc
fi

if command -v dbt &> /dev/null; then
    source ~/.dbt-completion.bash
    dbts() {
        dbt show --select "$1" --limit 1 --output json
    }
fi

# enable comments "#" expressions in the prompt shell
setopt INTERACTIVE_COMMENTS

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

# dbt completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit

# Starts starship
eval "$(starship init zsh)"