"--------------------------------------------------"
" vimでYAMLを書くときにやっておきたいこと
"--------------------------------------------------"
augroup load_yaml
  autocmd!
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

