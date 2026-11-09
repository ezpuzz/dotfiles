export HOMEBREW_NO_ENV_HINTS=1
export ZSH="$HOME/.oh-my-zsh"
DISABLE_UPDATE_PROMPT=true
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git docker docker-compose npm uv python aws gh httpie zoxide mise node fzf rust eza extract jsontools encode64 copypath copybuffer aliases)
# before oh-my-zsh: its plugins (zoxide, fzf, gh, eza, aws) look for mise-installed tools on PATH
eval "$(mise activate zsh)"
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
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export DOCKER_HIDE_LEGACY_COMMANDS=true

export FZF_DEFAULT_COMMAND='fd --type f --color=always'
export FZF_DEFAULT_OPTS='--ansi --inline-info'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Raise every soft resource limit to its hard maximum, but keep core dumps off
unlimit
limit coredumpsize 0

eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# LS_COLORS for eza and completion menus (gdircolors is brew coreutils)
eval "$(${commands[gdircolors]:-dircolors} -b ~/.LS_COLORS)"
alias ls='eza'
alias lg='git log --graph --abbrev-commit --decorate --date=short --format=format:"%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(white)%<(50,trunc)%s%C(reset)%n%C(dim white)%an%C(reset)%C(auto)%d%C(reset)%n"'
export PATH="$HOME/.local/bin:$PATH"
