"--------------------------------------------------"
" vimでJSONを書くときにやっておきたいこと
"--------------------------------------------------"
augroup load_json
  autocmd!
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

