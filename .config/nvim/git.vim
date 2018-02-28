call plug#begin('~/.config/nvim/plugged')
  Plug 'jacoborus/tender.vim'
  Plug 'roxma/nvim-completion-manager'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'fgrsnau/ncm-otherbuf'
  Plug 'tpope/vim-sensible'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'
call plug#end()

set background=dark
colorscheme tender

set cursorline
set formatoptions+=tcqln1j
set clipboard=unnamedplus

set noundofile
set nowrap
set nobackup
set noswapfile
set noshowmode
set noshowcmd

nnoremap j gj
nnoremap k gk

" completion
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
