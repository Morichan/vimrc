"--------------------------------------------------"
" vimで.vimrcを書くときにやっておきたいこと
"--------------------------------------------------"
augroup load_vimscript
  autocmd!
  autocmd BufNewFile,BufRead *.vimrc setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
  autocmd BufNewFile,BufRead *vimrc setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

