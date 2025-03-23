"--------------------------------------------------"
" vimでsh, bashを書くときにやっておきたいこと
"--------------------------------------------------"
augroup load_sh
  autocmd!
  autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

