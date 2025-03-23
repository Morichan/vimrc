"--------------------------------------------------"
" vimでPowerShellを書くときにやっておきたいこと
"--------------------------------------------------"
augroup load_ps1
  autocmd!
  autocmd FileType ps1 setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

