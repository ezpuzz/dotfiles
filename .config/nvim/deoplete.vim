set completeopt+=preview

" deoplete
let g:deoplete#enable_at_startup = 1

" fix filename completion after =
set isfname-==

" use tab to forward cycle
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" multiple cursors compat
function g:Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" one process per completion source
call deoplete#custom#option({
      \  'num_processes': 0,
      \  'auto_complete_delay': 20,
      \  'omni_patterns': {
      \    'gitcommit': ['\#.*', '@.*']
      \  },
      \  'sources':  {
      \    '_': [],
      \    'gitcommit': ['emoji', 'omni', 'around', 'file', 'buffer']
      \  }
      \})

if has('win32')
  call deoplete#custom#option({
  \  'num_processes': 1
  \ })
endif

call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

call deoplete#custom#var('omni', 'input_patterns', {
    \  'gitcommit': ['\#\w*', '@\w*']
    \})
call deoplete#custom#var('omni', 'functions', {
    \  'gitcommit': 'rhubarb#Complete'
    \})

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
