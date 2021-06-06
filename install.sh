#!/bin/sh -e

cat << EOF >> ~/.vimrc

" This is custom settings, for more details $(pwd)/README.md
set runtimepath+=$(pwd)/rc
let g:VIM_DOTFILES_ROOT_DIR='$(pwd)'
runtime! init.vim
EOF
