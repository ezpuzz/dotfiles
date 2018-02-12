
" Plugins
call plug#begin('~/.config/nvim/plugged')

  " terminal
  Plug 'kassio/neoterm'
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction

  " appearance
  Plug 'altercation/vim-colors-solarized'
  Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Linting
  Plug 'w0rp/ale'

  " completion
  Plug 'roxma/nvim-completion-manager'
  Plug 'roxma/ncm-flow'
  Plug 'othree/csscomplete.vim'

  " global vim commands
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'justinmk/vim-sneak'
  Plug 'wellle/targets.vim'
  Plug 'terryma/vim-multiple-cursors'

  " file format
  Plug 'editorconfig/editorconfig-vim'
  Plug 'Chiel92/vim-autoformat'
  Plug 'godlygeek/tabular'

  " file searching
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'mileszs/ack.vim'

  " source control
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " file types
  Plug 'plasticboy/vim-markdown'
  Plug 'kchmck/vim-coffee-script'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'tfnico/vim-gradle'
  Plug 'elzr/vim-json'

  " ruby / rails
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-bundler'
  Plug 'vim-ruby/vim-ruby'

  " react
  Plug 'flowtype/vim-flow'
  Plug 'mxw/vim-jsx'
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

set t_Co=16
set background=dark
let g:solarized_termcolors=16
let g:solarized_italic=0
let g:solarized_bold=0
color solarized

" use fancy airline fonts
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'

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


" use mousewheel in vim
set mouse=a

set clipboard=unnamedplus

nnoremap <C-p> :FZF<CR>


" persisten undo
set undofile

" better grepping
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:formatdef_custom_astyle_java = '"astyle --style=java --mode=java -pcHs4"'
let g:formatters_java = ['custom_astyle_java']

nnoremap <C-f> :Autoformat<CR>

set nowrap

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

set fdm=indent
set foldnestmax=3
set scrolloff=10
set foldlevel=3

autocmd FileType ruby compiler ruby

set wildmode=longest,list,full
set wildmenu

let g:ackprg = "ag --vimgrep"

if has ("win32")
  let g:neoterm_eof = "\r"
endif
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSend<cr>
vnoremap <silent> <f9> :TREPLSend<cr>

" run set test lib
nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" Git commands
command! -nargs=+ Tg :T git <args>


:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

set nobackup
set noswapfile

" nvim terminal mode
:tnoremap <Esc> <C-\><C-n>

" completion stuff
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set ttimeout
set ttimeoutlen=50
set autoindent
set backspace=indent,eol,start
