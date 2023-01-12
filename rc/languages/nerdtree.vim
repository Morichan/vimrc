"--------------------------------------------------"
" vimでNERDTreeを開くときにやっておきたいこと
"--------------------------------------------------"
augroup load_nerdtree
  autocmd!
  autocmd FileType nerdtree setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

