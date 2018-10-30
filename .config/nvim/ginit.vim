" set terminal font
if has('nvim')
  Guifont! PragmataProMonoLiga:h11
else
  set encoding=utf-8
  set guifont=PragmataProMonoLiga_NF:h11:cANSI:qDRAFT
endif

set termguicolors
set background=dark

"let g:solarized_nvimqt_italic=0
"let g:solarized_nvimqt_underline=0
"let g:solarized_nvimqt_bold=0
"colorscheme solarized_nvimqt
