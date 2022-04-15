# -----------------------------
# Language
# -----------------------------
#
export LANG=ja_JP.UTF-8

# -----------------------------
# Theme
# -----------------------------

autoload -Uz promptinit
promptinit
prompt adam1

# 色を使用
autoload -Uz colors ; colors

# -----------------------------
# History
# -----------------------------

setopt histignorealldups sharehistory

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# -----------------------------
# Editor
# -----------------------------

# エディタをnvimに設定
export EDITOR=nvim

# vim bind
bindkey -v

# -----------------------------
# 補完
# -----------------------------

# Use modern completion system
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
		   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# -----------------------------
# Directories
# -----------------------------

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

setopt auto_cd

# dir stack
DIRSTACKSIZE=100
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# beep を無効にする
setopt no_beep

# enable auto jump
eval "$(jump shell zsh)"

# -----------------------------
# Alias
# -----------------------------

alias vi='nvim'
alias la='ls -a'
alias ll='ls -l'

alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# tex
alias lmk='latexmk -pvc'

# git
alias g='git'

# -----------------------------
# Path
# -----------------------------

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


# nginx
export PATH="/usr/local/nginx/sbin:$PATH"

# go

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin 

# nvim
export XDG_CONFIG_HOME="$HOME/.config"
case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    export LIB_CLANG="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
    export DIR_CLANG="/Library/Developer/CommandLineTools/usr/lib/clang"
    ;;
  linux*)
    # ここに Linux 向けの設定
    export LIB_CLANG="/usr/lib/libclang.so.10"
    export DIR_CLANG="/usr/include/clang"
    ;;
esac

## google-cloud-sdk
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# k8s
alias k=kubectl
