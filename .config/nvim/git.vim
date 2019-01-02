set nocp
filetype off

" mintty cursor shapes
if has('win32unix')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

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
  Plug 'tpope/vim-rhubarb'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme tender

set cursorline
set textwidth=72
set nofoldenable

if has('nvim')
  source $HOME/.config/nvim/python.vim
  "source $HOME/.config/nvim/deoplete.vim
  set completeopt+=noinsert
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option({
        \  'num_processes': 1,
        \  'auto_complete_delay': 20,
        \  'refresh_always': v:false,
        \  'sources':  {
        \    'gitcommit': ['emoji', 'omni', 'around', 'file', 'buffer']
        \  }
        \})
  call deoplete#custom#source('omni', 'min_pattern_length', 1)
  call deoplete#custom#var('omni', 'input_patterns', {
      \  'gitcommit': ['\#\w*', '@\w*']
      \})
  call deoplete#custom#var('omni', 'functions', {
      \  'gitcommit': 'rhubarb#Complete'
      \})
endif


filetype plugin indent on
filetype on

syntax on
autocmd BufEnter * :syntax sync fromstart
