
set completeopt+=preview

" deoplete
let g:deoplete#enable_at_startup = 1

" one process per completion source
call deoplete#custom#option({
      \  'num_processes': 0,
      \  'omni_patterns': {
      \    'gitcommit': ['\#.*', '@.*']
      \  },
      \  'sources':  {
      \    '_': [],
      \    'gitcommit': ['around', 'file', 'buffer', 'emoji', 'omni']
      \  }
      \})

" use words from all buffers
call deoplete#custom#var('buffer', 'require_same_filetype', v:false)
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

" close preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" completion on tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger = "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/.config/nvim/plugged/vim-snippets/UltiSnips"

" LanguageClient
nnoremap <silent> <leader>lk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>

" Tern
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
