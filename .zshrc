export HOMEBREW_NO_ENV_HINTS=1
DISABLE_MAGIC_FUNCTIONS=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git docker docker-compose npm uv python aws gh httpie zoxide mise node fzf rust eza extract jsontools encode64 copypath copybuffer aliases)
# before oh-my-zsh: its plugins (zoxide, fzf, gh, eza, aws) look for mise-installed tools on PATH
eval "$(mise activate zsh)"
source $ZSH/oh-my-zsh.sh

eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# LS_COLORS for eza and completion menus (gdircolors is brew coreutils)
eval "$(${commands[gdircolors]:-dircolors} -b ~/.LS_COLORS)"
alias ls='eza'
alias lg='git log --graph --abbrev-commit --decorate --date=short --format=format:"%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(white)%<(50,trunc)%s%C(reset)%n%C(dim white)%an%C(reset)%C(auto)%d%C(reset)%n"'
export PATH="$HOME/.local/bin:$PATH"
