export LANG=ja_JP.UTF-8
export PROMPT="%m%# "
#export PROMPT="%# "
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit -u

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
setopt share_history

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

### For Mack
case ${OSTYPE} in
    darwin*)
        #ここにMac向けの設定
        export PATH=$PATH:/usr/local/share/npm/bin/
        # alias emacs='/opt/local/bin/emacs-23.4'
        # alias emacs23='/opt/local/bin/emacs-23.4'
        # alias emacs='/usr/local/bin/emacs-24.3'
        # alias emacs23='/usr/local/bin/emacs-24.3'
        # alias emacsclient='/opt/local/bin/emacsclient'
        # alias emacs-comp="emacs23 -batch -f byte-compile"
        # alias emacs-kill="emacsclient -e '(kill-emacs)'"
        alias ls="ls -G"
        export GOROOT=/usr/local/opt/go/libexec
        export GOPATH=$HOME/go
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
        export PATH=~/bin:/opt/local/bin:$PATH
        ;;
    linux*)
        #ここにLinux向けの設定
        alias emacs='/usr/local/bin/emacs-23.4'
        alias emacs23='/usr/local/bin/emacs-23.4'
        alias emacsclient='/usr/local/bin/emacsclient'
        alias emacs-comp="emacs23 -batch -f byte-compile"
        alias emacs-kill="emacsclient -e '(kill-emacs)'"
        ;;
esac


## rbenv
#
if [ -e /usr/local/bin/rbenv ]; then;
    export PATH=~/.rbenv/shims:$PATH
    #source "`brew --prefix rbenv`/completions/rbenv.zsh"
fi


alias ctags="/usr/local/bin/ctags"
export GISTY_DIR=/Users/callistoiv/works/git

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source /Users/callistoiv/.pythonbrew/etc/bashrc

source `which virtualenvwrapper.sh`
[[ -s /Users/callistoiv/.tmuxinator/scripts/tmuxinator ]] && source /Users/callistoiv/.tmuxinator/scripts/tmuxinator

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

## peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
#
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# if [ -e /usr/local/share/zsh-completions ]; then
#     fpath=(/usr/local/share/zsh-completions $fpath)
#     fpath=(/usr/local/share/zsh/site-functions/_lein $fpath)
#     export PATH=$PATH:/usr/local/opt/leiningen/bin/
# fi

# tmux
alias tmux="TERM=screen-256color tmux"
# Docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/callistoiv/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# #  caffe setting
# export CAFFE_DIR=~/works/project/dotfiles/vagrant/caffe
# export PYTHONPATH=$CAFFE_DIR/python
