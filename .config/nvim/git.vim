call plug#begin('~/.config/nvim/plugged')
  Plug 'jacoborus/tender.vim'

  Plug 'tpope/vim-sensible'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'

  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neco-syntax'
    Plug 'fszymanski/deoplete-emoji'
  endif

  " source control
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-rhubarb'
call plug#end()

set background=dark
colorscheme tender

if has('nvim')
  source $HOME/.config/nvim/deoplete.vim
endif
