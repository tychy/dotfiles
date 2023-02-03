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
case ${OSTYPE} in
  darwin*)
    eval "$(jump shell zsh)"
    ;;
  linux*)
    [[ -s /home/ryu/.autojump/etc/profile.d/autojump.sh ]] && source /home/ryu/.autojump/etc/profile.d/autojump.sh
    autoload -U compinit && compinit -u
    ;;
esac


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

# direnv
eval "$(direnv hook zsh)"

# -----------------------------
# Merpay
# -----------------------------
## google-cloud-sdk
#
if [ -e '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi


# k8s
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
alias k=kubectl
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

function auth() {
  gcloud auth login --update-adc
# gcloud auth login --update-adc --enable-gdrive-access
# gcloud auth application-default login --scopes "https://www.googleapis.com/auth/spreadsheets,https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/cloud-platform,openid"
  gcloud auth application-default set-quota-project merpay-alcazar-jp
}

alias arm="env /usr/bin/arch -arm64 /bin/zsh --login"
alias intel="env /usr/bin/arch -x86_64 /bin/zsh --login"

function set-kube-namespace() {
    kubectl config set-context $(kubectl config current-context) --namespace $(find $GOPATH/src/microservices-terraform/terraform/microservices -name backend.tf | awk -F/ '{ if($(NF-1) == "development") {print $(NF-2)"-dev"} else if($(NF-1) == "production") {print $(NF-2)"-prod"} }' | sort -u | peco)
}

function get-proto(){
	GOPRIVATE=github.com/kouzoh go get -u github.com/kouzoh/platform-client-go@$1
}

alias sp="spanner-cli -p merpay-alcazar-jp -i merpay-alcazar-jp3 -d ryuyama-dev"

# -----------------------------
# M1 Mac
# -----------------------------
# switch-arch
if [[ "$(uname)" == 'Darwin' ]]; then
  typeset -U path PATH
  path=(
      /opt/homebrew/opt/llvm/bin
      /usr/local/opt/llvm/bin
  	/opt/homebrew/bin(N-/)
  	/usr/local/bin(N-/)
      /opt/homebrew/opt/binutils/bin
      /usr/local/opt/binutils/bin
  	$path
  )
  
  if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
  	[[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
  	alias x64='exec arch -x86_64 /bin/zsh'
  	alias a64='exec arch -arm64e /bin/zsh'
  	switch-arch() {
  		if  [[ "$(uname -m)" == arm64 ]]; then
  			arch=x86_64
              export PATH=/usr/local/opt/llvm/bin:$PATH
              export PATH=/usr/local/opt/binutils/bin:$PATH
  		elif [[ "$(uname -m)" == x86_64 ]]; then
  			arch=arm64e
              export PATH=/opt/homebrew/opt/llvm/bin:$PATH
              export PATH=/opt/homebrew/sbin:/opt/homebrew/opt/binutils/bin:$PATH
  		fi
  		exec arch -arch $arch /bin/zsh
  	}
  fi
  
  setopt magic_equal_subst
fi


