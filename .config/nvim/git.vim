call plug#begin('~/.config/nvim/plugged')
  Plug 'jacoborus/tender.vim'

  Plug 'tpope/vim-sensible'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-syntax'
  Plug 'fszymanski/deoplete-emoji'

  " source control
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-rhubarb'
call plug#end()

set background=dark
colorscheme tender

source $HOME/.config/nvim/deoplete.vim
