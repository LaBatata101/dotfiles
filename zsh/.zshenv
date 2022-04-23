export ZSH=$HOME/.oh-my-zsh
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

export RANGER_LOAD_DEFAULT_RC=FALSE

# added by pipx (https://github.com/cs01/pipx)
export PATH="$HOME/.local/bin:$PATH"

export FZF_BASE=$(command -v fzf)

. "$HOME/.cargo/env"
