#!/bin/sh -e

cat << EOF >> ~/.vimrc

" This is custom settings, for more details $(pwd)/README.md
set runtimepath+=$(pwd)/settings
runtime! init/config.vim
runtime! plugins/*.vim
EOF
