export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_UPDATE_PROMPT=true
ZSH_THEME=""

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

DEFAULT_USER="emorypetermann"

plugins=(gpg-agent git yarn colored-man-pages cp docker docker-compose docker-machine kubectl ember-cli github per-directory-history zsh-syntax-highlighting rbenv)
source $ZSH/oh-my-zsh.sh

setopt menu_complete
setopt no_list_beep
bindkey -M menuselect '^M' .accept-line # execute command when menu selecting

zstyle ':bracketed-paste-magic' active-widgets '.self-*'

setopt magicequalsubst

setopt hist_ignore_all_dups

zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

export LANG=en_US.UTF-8

alias lg='git lg'
alias ag='ag --path-to-ignore ~/.agignore'
alias gpr='hub pull-request'
alias vim='nvim'
alias yc='yadm commit -v'
alias ys='yadm status'
alias yd='yadm diff'
alias make='make -j8'
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
export FZF_DEFAULT_OPTS='--ansi --inline-info'
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

ulimit -n 1024
ulimit -u 2048

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

export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"

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

# Docker stuff
DOCKER_HIDE_LEGACY_COMMANDS=true

# base16 color stuff
# Base16 Shell
BASE16_SHELL="$HOME/.base16-manager/chriskempson/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

source <(npx --shell-auto-fallback zsh)

#function zle-line-init zle-keymap-select {
  #PROMPT=`~/repos/purs/target/release/purs prompt -k "$KEYMAP" -r "$?"`
  #zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

#autoload -Uz add-zsh-hook

#function _prompt_purs_precmd() {
  #~/repos/purs/target/release/purs precmd --git-detailed
#}
#add-zsh-hook precmd _prompt_purs_precmd

autoload -U promptinit; promptinit
prompt pure
