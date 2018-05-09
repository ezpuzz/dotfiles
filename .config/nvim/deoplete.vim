
" deoplete
let g:deoplete#enable_at_startup = 1

" one process per completion source
call deoplete#custom#option({
      \  'num_processes': 0,
      \  'sources':  {
      \    '_': ['buffer', 'omni'],
      \    'gitcommit': ['buffer', 'emoji', 'omni']
      \  },
      \  'omni_patterns': {
      \    'gitcommit': ['\#', '@'],
      \  }
      \})

call deoplete#custom#var('omni', 'input_patterns', {
      \  'gitcommit': ['\#']
      \})

call deoplete#custom#source('buffer', 'require_same_filetype', v:false)

" close preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
