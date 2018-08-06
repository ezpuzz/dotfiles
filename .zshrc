# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git per-directory-history zsh-syntax-highlighting yarn)
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:$HOME/dotfiles/bin:/usr/lib/go-1.9/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

source $HOME/.rvm/scripts/rvm

export LANG=en_US.UTF-8

#alias ls='ls --color=auto'
alias lg='git lg'
alias ag='ag --path-to-ignore ~/.agignore'
alias gpr='hub pull-request'
alias vim='nvim'
alias yc='yadm commit -v'
alias make='make -j8'
alias lc='colorls -lA --sd'
alias mdv="mdv -t random"
alias kd="git difftool --no-symlinks --dir-diff"

#ember aliases
alias ei='ember install --yarn'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
  eval $(gdircolors $HOME/.LS_COLORS)
  alias ls='gls --color=auto'
else
  eval $(dircolors -b $HOME/.LS_COLORS)
fi

# FZF + fd
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
export FZF_DEFAULT_COMMAND='fd --type f --color=always'
export FZF_DEFAULT_OPTS='--ansi'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#export NDK_ROOT=/usr/local/Cellar/android-ndk/r10e
#export ANDROID_HOME=/Users/emorypetermann/Library/Android/sdk
#export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH"


# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
  git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
  git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}


# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}


# the below two functions are useful to set the current JDK. usage: `$ setjdk 1.6`
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export JDK_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK"
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

ulimit -n 1024
ulimit -u 2048

export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home

# "Windows subsystem for Linux" workarounds

if [[ -f /proc/version && $(</proc/version) == *Microsoft@Microsoft* ]]
then
  # Set correct umask
  # Microsoft/BashOnWindows#352
  if [[ "$(umask)" == '000' ]]
  then
    umask 022
  fi

  # Prevent ZSH from changing the priority of the background processes with nice.
  # Microsoft/BashOnWindows#1887
  unsetopt BG_NICE
fi

# v - open files in ~/.viminfo
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
    while read line; do
      [ -f "${line/\~/$HOME}" ] && echo "$line"
    done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
  }

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/Library/Haskell/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

source <(npx --shell-auto-fallback zsh)
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
