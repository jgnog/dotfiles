" Configurations for python files

" Ensure that tabs are 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" Display a colored column at column 80 to easily check line length
set cc=80

"""""""""""""""""""""""""""""
" python-mode configuration "
"""""""""""""""""""""""""""""

" Disable :PymodeRun
let g:pymode_run = 0

" Disable lint on every save
let g:pymode_lint_on_write = 0
" Disable lint on the fly
let g:pymode_lint_on_fly = 0
" Configure lint checkers
" Use these checkers:
" pylint - most complete syntax checker
" pep8 - code style checker
" pep257 - docstring style checker
let g:pymode_lint_checkers = ['pylint', 'pep8', 'pep257']
" Set python3 as default
let g:pymode_python = 'python3'
" Disable auto opening of quickfix window
let g:pymode_lint_cwindow = 0
" Map <leader>c to lint the current buffer
nnoremap <leader>c :PymodeLint<CR>
" Disable Rope completion on typing period
let g:pymode_rope_complete_on_dot = 0
