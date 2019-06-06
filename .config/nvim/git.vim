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

  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

  Plug 'tpope/vim-sensible'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'

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
endif


filetype plugin indent on
filetype on

syntax on
autocmd BufEnter * :syntax sync fromstart
