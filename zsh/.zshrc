#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz promptinit
promptinit
prompt paradox

# Customize to your needs...
export PATH=$HOME/bin:$PATH

alias ga="git add"
alias gc="git commit"
alias gs="git status -sb"
alias gd="git diff"
alias gdc="git diff --cached"

## peco
## see: http://qiita.com/kp_ohnishi/items/3009e2083831af3a7c5c
# peco-select-history () {
#     local tac
#     if which tac > /dev/null
#     then
#             tac="tac"
#     else
#             tac="tail -r"
#     fi
#     BUFFER=$(history -n 1 | \
#     eval $tac | \
#     peco --query "$LBUFFER")
#     CURSOR=$#BUFFER
#     zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history

# see: http://qiita.com/wada811/items/78b14181a4de0fd5b497
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    # zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
