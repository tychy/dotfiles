# Set up the prompt

export LANG=ja_JP.UTF-8

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# 色を使用
autoload -Uz colors ; colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# エディタをvimに設定
export EDITOR=vim

# dir stack
DIRSTACKSIZE=100
setopt AUTO_PUSHD

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
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# dircolor
case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export PATH=$PATH:/usr/local/bin
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# alias
alias vi='nvim'
alias la='ls -a'
alias ll='ls -l'

alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

alias pbcopy='xsel --clipboard --input'
alias kus='fcitx-imlist -s us'
alias kmozc='fcitx-imlist -s mozc'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.poetry/bin:$PATH"

# nginx
export PATH="/usr/local/nginx/sbin:$PATH"
# if os == linux gnu then sudoに現在のパスを渡す
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias sudo='sudo env PATH=$PATH'
fi

# julia
export PATH="$HOME/oss/julia:$PATH"

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

# nvim
export XDG_CONFIG_HOME="$HOME/.config"

# tex
alias lmk='latexmk -pvc'

# cpp
alias g11='g++ -std=c++11'

# lightline
export TERM=xterm-256color

# ruby gems for jekyll
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
alias buildj="bundle exec jekyll serve"
export PATH=~/.npm-global/bin:$PATH
# nodejs
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
# direnv
eval "$(direnv hook zsh)"

# git
alias g='git'

function with_echo() {
    echo $@
   $@
}
function cpp_compile() {
    with_echo g++ -std=c++14 -g -O0 -o $1 $2
}

function cpp_run() {
  cpp_file=$1
  exe_file=${cpp_file:0:-4}
  shift

  if [ -s $cpp_file ]; then
    if [ ! -f $exe_file ]; then
      cpp_compile $exe_file $cpp_file && ./$exe_file $@
    else
      cpp_date=`date -r $cpp_file +%s`
      exe_date=`date -r $exe_file +%s`
      if [ $cpp_date -gt $exe_date ]; then
        cpp_compile $exe_file $cpp_file && ./$exe_file $@
      else
        ./$exe_file $@
      fi
    fi
  else
    echo $cpp_file is empty
  fi
}
alias -s cpp=cpp_run
