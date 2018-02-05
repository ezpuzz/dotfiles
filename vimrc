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
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'mileszs/ack.vim'
  Plug 'tpope/vim-dispatch'
  Plug 'elzr/vim-json'
  Plug 'tpope/vim-rails'
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

set clipboard=

nnoremap <C-p> :FZF<CR>


" persisten undo
set undofile
set undodir=~/.vim/undo

" better grepping
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:syntastic_java_javac_classpath = '~/Library/Android/sdk/platforms/android-25/android.jar'

let g:formatdef_custom_astyle_java = '"astyle --style=java --mode=java -pcHs4"'
let g:formatters_java = ['custom_astyle_java']

nnoremap <C-f> :Autoformat<CR>

set wrap

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

set fdm=indent
set foldlevel=3
set foldnestmax=2

set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

set breakindent

set noea

au BufReadCmd *.aar call zip#Browse(expand("<amatch>"))

let g:indent_guides_auto_colors = 1

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ack_use_dispatch = 1

let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

:map <ScrollWheelUp> <C-Y>
:map <ScrollWheelDown> <C-E>

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
