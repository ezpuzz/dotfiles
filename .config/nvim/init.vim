" Install vim-plug if missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

" good default settings
Plug 'tpope/vim-sensible'

" terminal
" Plug 'kassio/neoterm'

" run tests within vim
Plug 'skywind3000/asyncrun.vim'
Plug 'janko-m/vim-test'

" global commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-projectionist'

" appearance
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'arakashic/nvim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'chrisbra/Colorizer'

" Code Style
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'

" Docs
Plug 'rizzatti/dash.vim'

" Linting
Plug 'w0rp/ale'

if has('nvim')
  " completion
  if has('win32') || has('win64')
    Plug 'autozimu/LanguageClient-neovim', {
	 \ 'branch': 'next',
	 \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
	 \ }
  else
    Plug 'autozimu/LanguageClient-neovim', {
	 \ 'branch': 'next',
	 \ 'do': 'bash install.sh',
	 \ }
  endif

  Plug 'ezpuzz/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-syntax'
  Plug 'Shougo/neco-vim'
  Plug 'ezpuzz/deoplete-emoji', { 'branch': 'submodule-emojis' }
  Plug 'zchee/deoplete-jedi'

  " TODO: use these with deoplete more
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif

" file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'

" source control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb' " issue numbers and mentions in git commit messages

" syntax
"
Plug 'bfontaine/Brewfile.vim'

Plug 'kchmck/vim-coffee-script'

Plug 'elzr/vim-json'

Plug 'tfnico/vim-gradle'

Plug 'chr4/nginx.vim'

Plug 'gabrielelana/vim-markdown'

" ember
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
Plug 'joukevandermaas/vim-ember-hbs', { 'for': ['html.handlebars'] }
Plug 'AndrewRadev/ember_tools.vim'

" html
Plug 'alvan/vim-closetag', { 'for': ['xml', 'html.handlebars', 'html', 'jsx'] }
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html.handlebars', 'html', 'jsx'] }

" ruby / rails
Plug 'tpope/vim-rails', { 'for': ['ruby'] }
Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }

" js
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }

" react
Plug 'HerringtonDarkholme/yats.vim'
if has('win32')
  Plug 'mhartington/nvim-typescript'
else
  Plug 'mhartington/nvim-typescript', {'do': './install.sh' }
endif
" Plug 'flowtype/vim-flow', { 'for': ['javascript'] }
" Plug 'mxw/vim-jsx', { 'for': ['javascript'] }

" python
Plug 'metakirby5/codi.vim', { 'for': ['python'] }
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }

" flutter
Plug 'reisub0/hot-reload.vim', { 'for': ['dart'] }
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': ['go'] }

" Docker
Plug 'ekalinin/Dockerfile.vim', { 'for': ['Dockerfile'] }

" time tracking
Plug 'wakatime/vim-wakatime'

" IMPORTANT: load fonts last
if !has('win32')
  Plug 'ryanoasis/vim-devicons'
endif

call plug#end()

" 24-bit color themes
if (has("termguicolors"))
  set termguicolors
endif

" let g:solarized_termcolors=16
" let g:solarized_italic=0
" let g:solarized_bold=0
if has('win32') || has('win32unix')
        " use default terminal background color
        if !has("gui_running")
          set t_Co=256
          let &t_AB="\e[48;5;%dm"
          let &t_AF="\e[38;5;%dm"
          "hi Normal ctermbg=NONE guibg=NONE
        endif

        set background=dark
        colorscheme gruvbox
else
        set background=light
        colorscheme solarized
endif

" reduce flicker
set noshowcmd

" use fancy airline fonts
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='light'
let g:airline_theme='solarized'
" let g:airline_theme='tenderplus'

" Show line numbers
set number

" Blink cursor on error instead of beeping (grr)
set visualbell

" highlight current line
set cursorline

" already have airline don't need double
set noshowmode

" Whitespace
set nowrap
set textwidth=100
set formatoptions+=cqln1j
set expandtab

" diffs
set diffopt=filler,vertical,iwhite

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

" fzf
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

set fdm=indent
set foldnestmax=3
set foldlevel=3

autocmd FileType ruby compiler ruby

set wildmode=longest,list,full
set wildmenu

let g:ackprg = "rg --vimgrep"

" REPL mappings
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>

" run set test lib
nnoremap <silent> ,rt :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rf :wa<cr>:TestFile<cr>
nnoremap <silent> ,rn :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rr :wa<cr>:TestLast<cr>

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

" gitgutter
set updatetime=100
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg --color=never'
" these signs replicated from gitgutter help file
let g:gitgutter_sign_added              = '+'
let g:gitgutter_sign_modified           = '~'
let g:gitgutter_sign_removed            = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed   = '~_'
let g:gitgutter_override_sign_column_highlight = 1

" Startify
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
if !has('win32')
  function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
  endfunction
endif

" AsyncRun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" vim-test
let test#strategy = 'asyncrun'

" ALE linting
let g:airline#extensions#ale#enabled = 1

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['tslint', 'prettier'],
\  'go': ['gofmt'],
\  'markdown': ['prettier']
\}
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['tslint', 'tsserver', 'typecheck'],
\  'go': ['gometalinter'],
\
\}
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1

" set system python to ignore virtualenv
let g:python_host_prog = "/usr/local/bin/python"
let g:python3_host_prog = "/usr/local/bin/python3"

" mustache
let g:mustache_abbreviations = 1

" hex colors
let g:colorizer_auto_filetype = 'javascript.jsx,css,html,sass,scss'
let g:colorizer_fgcontrast = -1
let g:colorizer_colornames = 0

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" closetag
let g:closetag_filenames = '*.html,*.hbs'
let g:closetag_filetypes = 'html,html.handlebars'

" dash.vim
let g:dash_activate = 0
nnoremap <Leader>d :Dash<CR>
let g:jedi#completions_enabled = 0

autocmd FileType markdown :AsyncRun grip -b %

autocmd FileType make setlocal noexpandtab

if has('nvim')
  source $HOME/.config/nvim/deoplete.vim
endif

source $HOME/.config/nvim/python.vim

" save all when leaving terminal
au FocusLost * silent! wa

autocmd BufEnter * :syntax sync fromstart
