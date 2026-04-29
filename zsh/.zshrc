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
# prompt paradox
# prompt sorin
prompt powerlevel10k

# Customize to your needs...
# Get the current operating system
os_name=$(uname -s)

# Common settings for all operating systems

# OS-specific settings using case statement
case $os_name in
    Darwin)
        # Add macOS-specific configurations here
        # For asdf
        export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
        # append completions to fpath
        fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

        test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
        ;;
    Linux)
        # Add Linux-specific configurations here
        . "$HOME/.asdf/asdf.sh"
        export PATH="$HOME/.asdf/bin:$PATH"
        # append completions to fpath
        fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
        ;;
    # FreeBSD)
    #     # FreeBSD settings
    #     # Add FreeBSD-specific configurations here
    #     ;;
    *)
        # Default settings for other operating systems
        # echo "Default settings for other OS"
        # Add default configurations here
        ;;
esac

export PATH=$HOME/bin:$PATH

# see: https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
export HISTSIZE=10000000
export SAVEHIST=10000000

alias ga="git add"
alias gp="git pull"
alias gc="git commit"
alias gs="git status -sb"
alias gd="git diff"
alias gdc="git diff --cached"

## peco
# see: http://qiita.com/kp_ohnishi/items/3009e2083831af3a7c5c
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
# source <(kubectl completion zsh)
# source <(minikube completion zsh)

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
