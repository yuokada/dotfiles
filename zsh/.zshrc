# Interactive Zsh configuration.

# Homebrew completion directories differ between Apple Silicon and Intel Macs.
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=(/opt/homebrew/share/zsh/site-functions "${fpath[@]}")
elif [[ -d /usr/local/share/zsh/site-functions ]]; then
  fpath=(/usr/local/share/zsh/site-functions "${fpath[@]}")
fi

# Prezto initializes completion and the configured prompt theme.
if [[ -s "${ZDOTDIR:-${HOME}}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-${HOME}}/.zprezto/init.zsh"
  if (( ${+functions[prompt_powerlevel10k_setup]} )); then
    prompt powerlevel10k
  fi
else
  autoload -Uz compinit
  compinit
fi

# mise replaces the former asdf initialization.
if (( ${+commands[mise]} )); then
  eval "$(mise activate zsh)"
fi

if [[ -r "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

HISTFILE="${ZDOTDIR:-${HOME}}/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull --rebase'
alias gs='git status -sb'

peco-select-history() {
  (( ${+commands[peco]} )) || return 1

  local selected
  selected="$(fc -rl 1 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' | awk '!seen[$0]++' | peco --query "${LBUFFER}")"
  [[ -n "${selected}" ]] || return 0

  BUFFER="${selected}"
  CURSOR=${#BUFFER}
}

zle -N peco-select-history
bindkey '^R' peco-select-history
