
" Plugins
call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" terminal
Plug 'kassio/neoterm'
Plug 'skywind3000/asyncrun.vim'
Plug 'janko-m/vim-test'

" default settings
Plug 'tpope/vim-sensible'

" global commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'

" appearance
Plug 'jacoborus/tender.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'chrisbra/Colorizer'

" Code Style
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'

" Linting
Plug 'w0rp/ale'

" Code Formatting
Plug 'Chiel92/vim-autoformat'

" completion
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'

" source control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" file types
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
Plug 'kchmck/vim-coffee-script', { 'for': ['coffeescript'] }
Plug 'mustache/vim-mustache-handlebars'
Plug 'tfnico/vim-gradle', { 'for': ['groovy'] }
Plug 'elzr/vim-json', { 'for': ['json'] }

" html
Plug 'alvan/vim-closetag', { 'for': ['xml', 'html', 'jsx'] }
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'jsx'] }

" ruby / rails
Plug 'tpope/vim-rails', { 'for': ['ruby'] }
Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }

" react
Plug 'flowtype/vim-flow', { 'for': ['javascript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
Plug 'mhartington/nvim-typescript', { 'for': ['javascript'] }

" python
Plug 'metakirby5/codi.vim', { 'for': ['python'] }

" syntax for everything else
" Plug 'sheerun/vim-polyglot'

" time tracking
Plug 'wakatime/vim-wakatime'

" IMPORTANT: load fonts last
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
set nowrap
set textwidth=100
set formatoptions+=cqln1j
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
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

" persisten undo
set undofile

" better grepping
if executable('rg')
  set grepprg=rg\ --nogroup\ --nocolor
endif

let g:formatdef_custom_astyle_java = '"astyle --style=java --mode=java -pcHs4"'
let g:formatters_java = ['custom_astyle_java']

let mapleader=","

" format on write
nnoremap <C-f> :Autoformat<CR>
" au BufWrite * :Autoformat

set fdm=indent
set foldnestmax=3
set foldlevel=3

autocmd FileType ruby compiler ruby

set wildmode=longest,list,full

let g:ackprg = "rg --vimgrep"

" REPL mappings
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>

nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
nmap gxx <Plug>(neoterm-repl-send-line)

" run set test lib
nnoremap <silent> ,rt :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rf :wa<cr>:TestFile<cr>
nnoremap <silent> ,rn :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rr :wa<cr>:TestLast<cr>

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

" vim-plug
let g:plug_threads=32

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/.config/nvim/plugged/vim-snippets/UltiSnips"

" gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg'

" Startify
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

" AsyncRun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" vim-test
let test#strategy = 'asyncrun'

" ALE linting
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_fixers = {
\  'javascript': ['prettier-eslint'],
\}
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1

" set system python to ignore virtualenv
let g:python_host_prog = "/usr/local/bin/python"

" LanguageClient
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
