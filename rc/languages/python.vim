"--------------------------------------------------"
" vimでPythonを書くときにやっておきたいこと
"--------------------------------------------------"
let g:syntastic_python_checkers = ["flake8"]
" flake8が未設定の場合はエラーを出さない
let g:syntastic_quiet_messages = { 'regex': 'flake8: bad interpreter:.*: no such file or directory' }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" docstring
autocmd BufNewFile,BufRead *.py syntax match pythonDocstring /"""\_.\{-}"""/ contains=pythonSpaceError,pythonDoctest,@Spell
autocmd BufNewFile,BufRead *.py syntax match pythonDocstring /'''\_.\{-}'''/ contains=pythonSpaceError,pythonDoctest,@Spell

" vim-docstring（docstringを折りたためる）
autocmd FileType python PyDocHide

" vim-pydocstring（docstringのテンプレを出力する）
let g:pydocstring_templates_dir = g:VIM_DOTFILES_ROOT_DIR . '/.vim/dein/repos/github.com/heavenshell/vim-pydocstring/test/templates/numpy/'

