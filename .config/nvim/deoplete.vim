
" deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
      \  'num_processes': 0
      \})

" completion on tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/.config/nvim/plugged/vim-snippets/UltiSnips"

" LanguageClient
nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
