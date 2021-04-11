set encoding=utf-8

if &compatible
  set nocompatible
endif

" to allow sourcing again without adding extra autocommands
autocmd!
let mapleader=","

packadd minpac

call minpac#init({ 'jobs': 0 })

" minpac help commands
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" FIXME: can't update self because submodule
"call minpac#add('k-takata/minpac', {'type': 'opt'})

" good default settings
call minpac#add('tpope/vim-sensible')

" keep good form
call minpac#add('takac/vim-hardtime')
let g:hardtime_default_on = 0

" allows to surround text objects with whatever
call minpac#add('tpope/vim-surround')
let b:surround_indent = 0

" some additional nice commands for commons stuff
call minpac#add('tpope/vim-unimpaired')

" allows you to repeat some commands from plugins
call minpac#add('tpope/vim-repeat')

" jump around related files
call minpac#add('tpope/vim-projectionist')
nnoremap <Leader>p :A<CR>

" automatically insert ending braces
call minpac#add('jiangmiao/auto-pairs')

" multiple cursors but has conflicts with things
"call minpac#add('terryma/vim-multiple-cursors')

" additional ways to navigate
"call minpac#add('justinmk/vim-sneak')

" additional text object targets
"call minpac#add('wellle/targets.vim')

" terminal inside of vim
"call minpac#add('kassio/neoterm')

" run tests within vim
"call minpac#add('skywind3000/asyncrun.vim')
if exists(':AsyncRun')
  command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
  let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
  "autocmd FileType markdown :AsyncRun grip -b %
  augroup vimrc
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
  augroup END
  augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
  augroup END
endif

call minpac#add('janko-m/vim-test')
nnoremap <silent> ,rt :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rf :wa<cr>:TestFile<cr>
nnoremap <silent> ,rn :wa<cr>:TestNearest<cr>
nnoremap <silent> ,rr :wa<cr>:TestLast<cr>
function! AsyncRunNoScrollStrategy(cmd)
  execute 'AsyncRun! '.a:cmd
endfunction
let g:test#custom_strategies = {'asyncnoscroll': function('AsyncRunNoScrollStrategy')}
let g:test#strategy = 'asyncnoscroll'
let g:test#runner_commands = ['Mocha']
let g:test#enabled_runners = ["javascript#mocha"]
let g:test#preserve_screen = 1

" appearance and themes
call minpac#add('morhetz/gruvbox')
"call minpac#add('jacoborus/tender.vim')

call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='light'
let g:airline_theme='angr'
" let g:airline_theme='tenderplus'

call minpac#add('mhinz/vim-startify')
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_session_sort = 1
if !has('win32')
  function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
  endfunction
endif

" show hex colors as the color they are
"call minpac#add('chrisbra/Colorizer')
"let g:colorizer_auto_filetype = 'javascript.jsx,css,html,sass,scss'
"let g:colorizer_fgcontrast = -1
"let g:colorizer_colornames = 0


" rainbow parens
" FIXME: problem with javascrip syntax
" minpac#add('luochen1990/rainbow')
"let g:rainbow_active = 1

" Code Style
call minpac#add('editorconfig/editorconfig-vim')
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"call minpac#add('junegunn/vim-easy-align')
call minpac#add('scrooloose/nerdcommenter')

" Docs
"call minpac#add('rizzatti/dash.vim')
" dash.vim
"let g:dash_activate = 0
"nnoremap <Leader>d :Dash<CR>
"call minpac#add('Shougo/echodoc.vim')

" project mgmt
"call minpac#add('jceb/vim-orgmode')

" Linting and Formatting
source $HOME/.config/nvim/ale.vim
call minpac#add('dense-analysis/ale')

" TODO: figure out formatting for handlebars
" prettydiff - bad CLI, mangles comments
" html-beautify - bad compat with handlebars


"call minpac#add('neoclide/coc.nvim', {'do': 'silent! yarn install --frozen-lockfile'})
"source $HOME/.config/nvim/coc.vim

" file searching
call minpac#add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'})
call minpac#add('junegunn/fzf.vim')
let $FZF_DEFAULT_COMMAND = 'rg --files'
nnoremap <C-p> :FZF<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

call minpac#add('mileszs/ack.vim')
let g:ackprg = "rg --vimgrep"

call minpac#add('yssl/QFEnter')
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" source control
call minpac#add('tpope/vim-fugitive')
call minpac#add('airblade/vim-gitgutter')
set updatetime=800 " according to gitgutter docs
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg --color=never'

" rhubarb issue numbers and mentions in git commit messages
call minpac#add('tpope/vim-rhubarb')

"call minpac#add('rhysd/committia.vim')

" syntax
"
"call minpac#add('bfontaine/Brewfile.vim')

"call minpac#add('kchmck/vim-coffee-script', { 'for': ['coffeescript'] })
call minpac#add('elzr/vim-json')

"call minpac#add('tfnico/vim-gradle')
"call minpac#add('stephpy/vim-yaml')
"call minpac#add('Einenlum/yaml-revealer')

"call minpac#add('chr4/nginx.vim')

call minpac#add('gabrielelana/vim-markdown')

call minpac#add('jparise/vim-graphql')

"call minpac#add('fatih/vim-go', { 'do': ':GoUpdateBinaries' })

" ember
" vim-mustache-handlebars has % jumping for if/else but missing some highights for ember stuff
call minpac#add('mustache/vim-mustache-handlebars')
let g:mustache_abbreviations = 1

" vim-ember-hbs slightly better at highlighting but no % jumping between matching if/else tags
"call minpac#add('joukevandermaas/vim-ember-hbs')
" handlebars indent is messed up without manual filetype
" also syntax gets reset after format
"augroup handlebarsIndent
"au!
"au Filetype html.handlebars setlocal filetype=html.handlebars syntax=mustache
"augroup END

call minpac#add('AndrewRadev/ember_tools.vim')

call minpac#add('othree/html5.vim')
let g:html_indent_inctags = "p,div,LinkTo"

" html
call minpac#add('alvan/vim-closetag')
let g:closetag_filenames = '*.html,*.hbs'
let g:closetag_filetypes = 'html,html.handlebars'

"call minpac#add('mattn/emmet-vim', { 'for': ['xml', 'html.handlebars', 'html', 'jsx'] })

" ruby / rails
"call minpac#add('tpope/vim-rails', { 'for': ['ruby'] })
"call minpac#add('tpope/vim-bundler', { 'for': ['ruby'] })
"call minpac#add('vim-ruby/vim-ruby', { 'for': ['ruby'] })

" js
call minpac#add('pangloss/vim-javascript')

"call minpac#add('tapayne88/vim-mochajs')


" both of these are typescript syntax but don't know which is bettter
"call minpac#add('HerringtonDarkholme/yats.vim')
"call minpac#add('leafgarland/typescript-vim')

" for future use if needed
"call minpac#add('flowtype/vim-flow')
call minpac#add('MaxMEllon/vim-jsx-pretty')
"
" python
"call minpac#add('metakirby5/codi.vim', { 'for': ['python'] })
"call minpac#add('davidhalter/jedi-vim', { 'for': ['python'] })
"let g:jedi#completions_enabled = 0

" flutter
"call minpac#add('reisub0/hot-reload.vim', { 'for': ['dart'] })
"call minpac#add('dart-lang/dart-vim-plugin', { 'for': ['dart'] })

" Docker
"call minpac#add('ekalinin/Dockerfile.vim', { 'for': ['Dockerfile'] })

" powershell
call minpac#add('PProvost/vim-ps1')

" Jenkins
"call minpac#add('martinda/Jenkinsfile-vim-syntax')

" time tracking
call minpac#add('wakatime/vim-wakatime')

" IMPORTANT: load fonts last
if !has('win32')
  call minpac#add('ryanoasis/vim-devicons')
endif

" 24-bit color themes
if has("termguicolors")
  set termguicolors
endif

if has('gui_running')
  set lines=60
  set co=130
  set guifont=PragmataPro\ Mono\ Liga:h12
  set guioptions-=L
  set guioptions-=T
  set guioptions-=t
  set guioptions-=m
  set guioptions-=r
  set guioptions+=c
  winp 1400 150
endif

" mintty cursor shapes
if has('win32unix') || has('unix')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

if has('win32') || has('win32unix')
  " use default terminal background color
  if !has("gui_running")
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    "hi Normal ctermbg=NONE guibg=NONE
  endif

  set background=dark
  let g:gruvbox_italic=0
  colorscheme gruvbox

  set lsp=1

  if !has('nvim')
    set bdlay=0
    set rop=type:directx
  endif
else
  call minpac#add('lifepillar/vim-solarized8')
  let g:solarized_extra_hi_groups=1
  set background=light
  colorscheme solarized8
endif

" prevent accidental quit
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

" visual
set number
set visualbell
set cursorline

" Whitespace
set nowrap
set textwidth=100
set formatoptions+=cqln1jro
set expandtab

" diffs
set diffopt=filler,vertical,iwhite

" Cursor motion
set scrolloff=3
set matchpairs+=<:> " use % to jump between pairs

" Move up/down editor lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj

" Allow hidden buffers
set hidden

" Last line
set noshowmode
set noshowcmd

" Searching
set hlsearch
set ignorecase
set smartcase
set showmatch
vnoremap // y/<C-R>"<CR>

" use mousewheel in vim
set mouse=a

" better grepping
if executable('rg')
  set grepprg=rg\ --nogroup\ --nocolor
endif

set fdm=indent
set foldnestmax=3
set foldlevel=3

set wildmode=longest,list,full
set wildmenu

" REPL mappings
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>

nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
nmap gxx <Plug>(neoterm-repl-send-line)

" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" nvim terminal mode
:tnoremap <Esc> <C-\><C-n>

autocmd FileType ruby compiler ruby
" Rails commands
"command! Troutes :T rake routes
"command! -nargs=+ Troute :T rake routes | grep <args>
"command! Tmigrate :T rake db:migrate

set nobackup
set nowritebackup

set swapfile
set undofile

set directory=~/.config/nvim/.swp/
set undodir=~/.config/nvim/.undo/

set smartindent

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd FileType make setlocal noexpandtab

if has('mac')
  let g:clipboard = {
        \ 'name': 'pbcopy',
        \ 'copy': {
        \    '+': 'pbcopy',
        \    '*': 'pbcopy',
        \  },
        \ 'paste': {
        \    '+': 'pbpaste',
        \    '*': 'pbpaste',
        \ },
        \ 'cache_enabled': 0,
        \ }
endif

set clipboard=unnamed

source $HOME/.config/nvim/python.vim

" save all when leaving terminal
au FocusLost * silent! wa

" ensure syntax always on
autocmd BufEnter * :syntax sync fromstart
syntax on

" create non-existent directories for new files
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
