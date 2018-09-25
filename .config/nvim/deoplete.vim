
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

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use words from all buffers
call deoplete#custom#var('buffer', 'require_same_filetype', v:false)
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

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
