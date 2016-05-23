" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'bling/vim-airline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'scrooloose/syntastic'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-fugitive'
  Plug 'Chiel92/vim-autoformat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tfnico/vim-gradle'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'wellle/targets.vim'
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" highlight current line
set cursorline

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Color scheme (terminal)
set t_Co=16
set background=dark
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_bold=0
let g:solarized_underline=0
colorscheme solarized

" use fancy airline fonts
let g:airline_powerline_fonts = 1

" use mousewheel in vim
set mouse=a

set clipboard=unnamed

nnoremap <C-p> :FZF<CR>


" persisten undo
set undofile
set undodir=/Users/emorypetermann/.vim/undo

" better grepping
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:syntastic_java_javac_classpath = '/Users/emorypetermann/repos/android-sdk/ads-sdk-build/heyzap-ads-sdk.jar:/Users/emorypetermann/Library/Android/sdk/platforms/android-21/android.jar'

let g:formatdef_custom_astyle_java = '"astyle --style=java --mode=java -pcHs4"'
let g:formatters_java = ['custom_astyle_java']

nnoremap <C-f> :Autoformat<CR>

set nowrap

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

set fdm=indent
set foldlevel=1
set foldnestmax=2

set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
