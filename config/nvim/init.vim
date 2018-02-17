
" Plugins
call plug#begin('~/.config/nvim/plugged')

  " terminal
  Plug 'kassio/neoterm'
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction

  " appearance
  Plug 'jacoborus/tender.vim'
  Plug 'altercation/vim-colors-solarized'
  Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'

  " Linting
  Plug 'w0rp/ale'

  " completion
  Plug 'roxma/nvim-completion-manager'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'roxma/ncm-flow'
  Plug 'calebeby/ncm-css'
  Plug 'fgrsnau/ncm-otherbuf'
  Plug 'othree/csscomplete.vim', { 'for': ['css', 'jsx'] }

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
  Plug 'tfnico/vim-gradle', { 'for': ['groovy'] }
  Plug 'elzr/vim-json', { 'for': ['json'] }

  " ruby / rails
  Plug 'tpope/vim-rails', { 'for': ['ruby'] }
  Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
  Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }

  " react
  Plug 'flowtype/vim-flow'
  Plug 'mxw/vim-jsx'
  Plug 'mhartington/nvim-typescript'

  " time tracking
  Plug 'wakatime/vim-wakatime'

  " load fonts last
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" 24-bit color themes
if (has("termguicolors"))
  set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set background=dark

" let g:solarized_nvimqt_italic=0
" let g:solarized_nvimqt_underline=0
" let g:solarized_nvimqt_bold=0
" colorscheme solarized_nvimqt

" alt colors for configured term
" let g:solarized_termcolors=16
" let g:solarized_italic=0
" let g:solarized_bold=0
" colorscheme solarized

colorscheme tender

" use fancy airline fonts
let g:airline_powerline_fonts = 1
" let g:airline_solarized_bg='dark'
let g:airline_theme='tenderplus'

" Show line numbers
set number

" Blink cursor on error instead of beeping (grr)
set visualbell

" highlight current line
set cursorline

" Security
set modelines=0

" Whitespace
set wrap
set textwidth=100
set formatoptions+=tcqln1j
set expandtab

" editorconfig will take care of indentation
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Cursor motion
set scrolloff=3
set matchpairs+=<:> " use % to jump between pairs

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set ignorecase
set smartcase
set showmatch

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

set fdm=indent
set foldnestmax=3
set foldlevel=3

autocmd FileType ruby compiler ruby

set wildmode=longest,list,full

let g:ackprg = "rg --vimgrep"

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

" nvim terminal mode
:tnoremap <Esc> <C-\><C-n>

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

set smartindent

let g:plug_threads=32


" completion stuff
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<Plug>(ultisnips_expand)":"\<CR>")

let $NVIM_NCM_MULTI_THREAD = 1

let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/.config/nvim/plugged/vim-snippets/UltiSnips"

let g:gitgutter_map_keys = 0
let g:gitgutter_grep_command = 'ag'
