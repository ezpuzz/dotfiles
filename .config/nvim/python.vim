if has('win32') || has('win64')
 let g:python_host_prog = "C:/Users/invad/.windows-build-tools/python27/python"
 "let g:python3_host_prog = "C:/Users/invad/AppData/Local/Programs/Python/Python37-32/python"
else
 " set system python to ignore virtualenv
 let g:python_host_prog = "/usr/local/bin/python"
 let g:python3_host_prog = "/usr/local/bin/python3"
endif
