set encoding=utf-8

if &compatible
  set nocompatible
endif

" to allow sourcing again without adding extra autocommands
autocmd!

packadd minpac

call minpac#init({ 'jobs': 0 })

" mintty cursor shapes
if has('win32unix')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

call minpac#add('jacoborus/tender.vim')

call minpac#add('neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'})
source $HOME/.config/nvim/coc.vim

call minpac#add('tpope/vim-sensible')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('wakatime/vim-wakatime')

" source control
"call minpac#add('tpope/vim-fugitive')
"call minpac#add('tpope/vim-rhubarb')

call minpac#add('tpope/vim-unimpaired')
call minpac#add('dense-analysis/ale')

if has("termguicolors")
  set termguicolors
endif

colorscheme tender
set background=dark

set nofoldenable
set textwidth=72
set clipboard=unnamed

if has('nvim')
  source $HOME/.config/nvim/python.vim
endif

" syntax all the way down
autocmd BufEnter * :syntax sync fromstart
