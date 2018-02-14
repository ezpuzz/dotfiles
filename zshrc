# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"

export UPDATE_ZSH_DAYS=1

# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git bundler rake ruby rails gem per-directory-history zsh-syntax-highlighting)

# User configuration

export PATH="$PATH:$HOME/dotfiles/bin:$HOME/.rvm/bin:/usr/lib/go-1.9/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias ls='ls --color=auto'
alias lg='git lg'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval `dircolors ~/dotfiles/LS_COLORS`

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

export NDK_ROOT=/usr/local/Cellar/android-ndk/r10e
export ANDROID_HOME=/Users/emorypetermann/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH"

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

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

# v - open files in ~/.viminfo
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

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

ulimit -n 65536
ulimit -u 2048

export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home

# Make less the default pager, add some options and enable syntax highlight using source-highlight
LESSPIPE=`which /usr/share/source-highlight/src-hilite-lesspipe.sh`
[ -n "$LESSPIPE" ] && export LESSOPEN="| ${LESSPIPE} %s"
less_options=(
  # If the entire text fits on one screen, just show it and quit. (Be more
  # like "cat" and less like "more".)
  --quit-if-one-screen

  # Do not clear the screen first.
  --no-init

  # Like "smartcase" in Vim: ignore case unless the search pattern is mixed.
  --ignore-case

  # Do not automatically wrap long lines.
  --chop-long-lines

  # Allow ANSI colour escapes, but no other escapes.
  --RAW-CONTROL-CHARS

  # Do not ring the bell when trying to scroll past the end of the buffer.
  --quiet

  # Do not complain when we are on a dumb terminal.
  --dumb
);
export LESS="${less_options[*]}"
export PAGER='less'
export MANPAGER="less -X"

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
