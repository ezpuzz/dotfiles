if has('win32') || has('win64')
 let g:python_host_prog = "C:/Users/invad/.windows-build-tools/python27/python"
 "let g:python3_host_prog = "C:/Users/invad/AppData/Local/Programs/Python/Python37-32/python"
else
 " mise's global python, so an active virtualenv or project python is ignored
 let g:python3_host_prog = expand('~/.local/share/mise/installs/python/latest/bin/python3')
endif
