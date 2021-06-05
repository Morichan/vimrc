#!/bin/sh -e

cat << EOF >> ~/.vimrc

" This is custom settings, for more details $(pwd)/README.md
set runtimepath+=$(pwd)/settings
runtime! plugins/*.vim
EOF
