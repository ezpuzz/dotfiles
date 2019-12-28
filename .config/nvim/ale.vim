" ALE linting
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'scss': ['prettier', 'stylelint'],
\  'json': ['prettier'],
\  'graphql': ['prettier'],
\  'javascript': ['eslint'],
\  'typescript': ['tslint', 'prettier'],
\  'javascriptreact': ['eslint'],
\  'go': ['gofmt'],
\  'markdown': ['prettier'],
\  'yaml': ['prettier'],
\  'python': ['autopep8', 'remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint'],
\  'typescript': ['eslint', 'tslint', 'tsserver'],
\  'go': ['gofmt', 'gobuild', 'golangci-lint'],
\  'handlebars': ['alex', 'ember-template-lint'],
\  'html': ['alex', 'writegood'],
\  'markdown': ['alex', 'writegood', 'markdownlint', 'mdl', 'proselint'],
\}

let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 1

let g:ale_completion_enabled = 0
let g:ale_history_enabled = 1

" faster eslint at risk of incompat
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_go_gometalinter_options = '--fast'
let g:ale_ruby_rubocop_executable = 'bundle'
