# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/nvim

# ページャ
export PAGER=/usr/local/bin/vimpager
export MANPAGER=/usr/local/bin/vimpager

# -------------------------------------
# zshのオプション
# -------------------------------------

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt notify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt append_history
setopt share_history
setopt extended_history

# 補完
setopt auto_list
setopt auto_menu
setopt auto_param_keys

setopt complete_in_word

setopt glob
setopt extended_glob
setopt mark_dirs

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

unsetopt list_beep

REPORTTIME=3

# -------------------------------------
# パス
# -------------------------------------

# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# export M2_HOME=$HOME/maven/3.3.9
# export PATH=$PATH:$M2_HOME/bin 

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

export PATH="$HOME/.anyenv/bin:$PATH"

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.nodebrew/current/npm/bin:$PATH
export PATH=$HOME/.npm/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.tmux/bin:$PATH

# golang
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
export PATH=/usr/local/opt/go/libexec/bin:$PATH

# PHP
export PATH=$HOME/.composer/vendor/bin:$PATH

# Python
export PATH=$HOME/Library/Python/2.7/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

# gettext
export PATH=/usr/local/opt/gettext/bin:$PATH

# Sqlite
export PATH=/usr/local/opt/sqlite/bin:$PATH

# Deno
export PATH=$HOME/.deno/bin:$PATH

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%K{blue}%~%k"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# Support for bash
PROMPT_COMMAND='prompt'

# Mirrored support for zsh. See: https://superuser.com/questions/735660/whats-the-zsh-equivalent-of-bashs-prompt-command/735969#735969 
precmd() { eval "$PROMPT_COMMAND" }

function prompt()
{
    if [ "$PWD" != "$MYOLDPWD" ]; then
        MYOLDPWD="$PWD"
        test -e .venv && workon `cat .venv`
    fi
}

# -------------------------------------
# エイリアス
# -------------------------------------
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="LC_COLLATE=C ls -G" # color for darwin
alias l="ls -la"
alias ll="ls -l"
alias la="ls -la"
alias l1="ls -1"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

alias gmom="git fetch && git merge origin/master"
alias gmod="git fetch && git merge origin/develop"
alias gpor="git push origin `git rev-parse --abbrev-ref HEAD`"
alias gpuo="git push --set-upstream origin"
alias gpuc="git push --set-upstream origin `git_current_branch`"
alias chrome="open -a Google\ Chrome"
alias finder="open -a Finder"
alias atom="open -a Atom"

alias vi="/usr/local/bin/nvim"

#ruby bundler
alias be="bundle exec"
alias bi="bundle install"

#util
alias groot="cd ./$(git rev-parse --show-cdup)"
alias f="open ."
alias u="cd ~"
alias p="cd ~/Projects"

alias j="z"

# chrome
if [ `uname` = "Darwin" ]; then
  alias google-chrome='open -a Google\ Chrome'
fi
alias chrome='google-chrome'

alias -s html=chrome

# -------------------------------------
# エイリアス
# -------------------------------------

# z
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
   z --add "$(pwd -P)"
}

#cd to where the active Finder opens
cdf () {
        target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
        if [ "$target" != "" ]
        then
                cd "$target"
                pwd
        else
                echo 'No Finder window found' >&2
        fi
}
#cd to where the key match with grep search from current dir
jj () {
    if [ $1 ]; then
        JUMPDIR=$(find . -type d -maxdepth 1 | grep $1 | tail -1)
        if [[ -d $JUMPDIR && -n $JUMPDIR ]]; then
            cd $JUMPDIR
        else
            echo "directory not found"
        fi
    fi
}

#for rails
alias be="bundle exec"

# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -e

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -1 }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zaw"
zplug "zsh-users/zsh-completions"
zplug "plugins/git", from:oh-my-zsh
zplug "mollifier/anyframe"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

bindkey -e

function toon {
  echo -n ""
}

bindkey '^r^h' anyframe-widget-execute-history
bindkey '^r^b' anyframe-widget-checkout-git-branch
bindkey '^r^f' anyframe-widget-cdr

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook is-at-least
add-zsh-hook chpwd chpwd_recent_dirs

# 補完
zstyle ':completion:*' verbose yes
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' use-cache true
zstyle ':completion:*' completer _complete _expand _match _prefix _list _history _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

zplug load

# prompt style
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='
%F{yellow}[%~]%f `vcs_echo`
%(?.$.%F{red}$%f) '

export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Generate a new Jekyll post
#
# @param $1 - Post slug
# @param $2 - Post title
function new-post {
  post="_posts/$(date +%Y-%m-%d)-$1.md"
  if [[ -f "$post" ]]; then
    echo "Post '$1' already exists"
  else
    touch "$post"
    echo "---" >> $post
    echo "layout: post" >> $post
    echo "title: \"$2\"" >> $post
    echo "date: $(date +'%Y-%m-%d %H:%M:%S %z')" >> $post
    echo "---" >> $post
    echo "Created post '$1'"
  fi
}
#
### zaw
bindkey '^[d' zaw-cdr
bindkey '^[g' zaw-git-branches
bindkey '^[@' zaw-gitdir

function zaw-src-gitdir () {
    _dir=$(git rev-parse --show-cdup 2>/dev/null)
    if [ $? -eq 0 ]
    then
        candidates=( $(git ls-files ${_dir} | perl -MFile::Basename -nle \
                                                   '$a{dirname $_}++; END{delete $a{"."}; print for sort keys %a}') )
    fi

    actions=("zaw-src-gitdir-cd")
    act_descriptions=("change directory in git repos")
}

function zaw-src-gitdir-cd () {
    BUFFER="cd $1"
    zle accept-line
}

zaw-register-src -n gitdir zaw-src-gitdir


alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'
alias -g C='| cat'

eval "$(anyenv init -)"
eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# https://github.com/tmuxinator/tmuxinator
source ~/.bin/tmuxinator.zsh

function rust_run() {
  rustc $1
  local binary=$(basename $1 .rs)
  ./$binary
}

alias rsrun='rust_run'

# for neovim
export XDG_CONFIG_HOME=~/.config
