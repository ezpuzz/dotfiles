# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_UPDATE_PROMPT=true
ZSH_THEME=""

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

DEFAULT_USER="emory"

plugins=(gpg-agent colored-man-pages)
plugins+=(gitfast git git-auto-fetch)
plugins+=(yarn)
plugins+=(docker docker-compose)
plugin+=(pyenv python)
plugins+=(z)
source $ZSH/oh-my-zsh.sh

setopt menu_complete
setopt no_list_beep
bindkey -M menuselect '^M' .accept-line # execute command when menu selecting

zstyle ':bracketed-paste-magic' active-widgets '.self-*'

setopt magicequalsubst

setopt hist_ignore_all_dups

# more wild autocomplete to skip letters in words
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

export LANG=en_US.UTF-8
export MAKEFLAGS="-j$(nproc)"

alias lg='git lg'
alias vim='nvim'
alias yc='yadm commit -v'
alias ys='yadm status'
alias yd='yadm diff'
alias mdv="mdv -t random"
alias kd="git difftool --no-symlinks --dir-diff"
alias dp="docker container prune -f && docker volume prune -f"
alias bss="brew services start"

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

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

# Increase ulimits (for broccoli for example)
ulimit -n 1024
ulimit -u 2048
ulimit -Sn 16384

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

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd /usr/local/opt/
pathadd $HOME/.local/bin
pathadd $HOME/.yarn/bin

export DOCKER_HIDE_LEGACY_COMMANDS=true

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"
