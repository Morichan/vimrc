" "--------------------------------
" " Start NeoBundle Settings.
" "--------------------------------
"
" set nocompatible
" filetype off
" " runtimepathにneobundle.vimを追加
" if has('vim_starting')
"     set nocompatible
"     set runtimepath+=~/.vim/bundle/neobundle.vim
"     " Required:
"     call neobundle#begin(expand('~/.vim/bundle/')) " begin(expand('~/.vim/bundle/'))
" endif
"
" " neobundle自体をneobundleで管理
" " NeoBundleを更新するための設定
" NeoBundleFetch 'Shougo/neobundle.vim'
"
" " neobundle.vimの初期化
" " call neobundle#rc(expand('~/.vim/bundle'))
"
" "
" " 読み込むプラグインを記載
" "
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'itchyny/lightline.vim'
"
" " コメントON/OFFを手軽に実行
" " <C--> を2回押す
" " Ubuntuの端末だと縮小化が先にされて反応してくれない
" NeoBundle 'tomtom/tcomment_vim'
"
" " インデントに色を付けて見やすくする
" NeoBundle 'nathanaelkane/vim-indent-guides'
" " 行末の半角スペースを可視化
" NeoBundle 'bronson/vim-trailing-whitespace'
"
" " ファイルをtree表示してくれる
" NeoBundle 'scrooloose/nerdtree'
"
" " Perlで何かしてくれる？よくわからん
" NeoBundle 'vim-perl/vim-perl' ", { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
"
" " solarizedを使う
" NeoBundle 'altercation/vim-colors-solarized'
"
" NeoBundle 'gmarik/vundle'
"
" " Perlでお世話になる方々
" NeoBundle 'petdance/vim-perl'
" NeoBundle 'hotchpotch/perldoc-vim'
"
" " snippetを使う（最新版）
" NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'
" " snippetを使う（旧版）
" " NeoBundle 'Shougo/neocomplcache'
" " NeoBundle 'Shougo/neocomplcache-snippets-complete'
" " NeoBundle 'thinca/vim-quickrun'
"
" call neobundle#end()
" "
" " 読み込むNeoBundleプラグインはここまで
" "
"
" " Required:
" " 読み込んだプラグインも含め、
" " ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化
" filetype plugin indent on
" filetype indent on
" " syntax on
"
" " インストールのチェック
" NeoBundleCheck
" "-----------------------------
" " End NeoBundle Settings.
" "-----------------------------



""
" Dein: next generation of NeoBundle
" supported from more vim7.4
"

"--------------------------------
" Start Dein Settings.
"--------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

"
" 読み込むプラグインを記載
"
call dein#add('Shougo/unite.vim')
call dein#add('itchyny/lightline.vim')

" コメントON/OFFを手軽に実行
" <C--> を2回押す
" Ubuntuの端末だと縮小化が先にされて反応してくれない
call dein#add('tomtom/tcomment_vim')

" キーマッピングを変更する設定を記述できる
call dein#add('kana/vim-submode')

" 対括弧の移動強化
call dein#add('andymass/vim-matchup')

" インデントに色を付けて見やすくする
call dein#add('nathanaelkane/vim-indent-guides')
" 行末の半角スペースを可視化
call dein#add('bronson/vim-trailing-whitespace')
" 括弧の可読性向上
call dein#add('luochen1990/rainbow')

" 強制的にクリップボードからコピーできるようにする
call dein#add('kana/vim-fakeclip')

" ファイルをtree表示してくれる
call dein#add('scrooloose/nerdtree')

" インテリジェントな補完機能
call dein#add('zxqfl/tabnine-vim')

" Perlで何かしてくれる？よくわからん
call dein#add('vim-perl/vim-perl')

call dein#add('ConradIrwin/vim-bracketed-paste')

" solarizedを使う
call dein#add('altercation/vim-colors-solarized')

" molokaiを使う
call dein#add('tomasr/molokai')

" monokai-proを使う
call dein#add('phanviet/vim-monokai-pro')

" gruvboxを使う
call dein#add('morhetz/gruvbox')

call dein#add('gmarik/vundle')

" Perlでお世話になる方々
call dein#add('petdance/vim-perl')
call dein#add('hotchpotch/perldoc-vim')

" Rustでお世話になる方々
call dein#add('racer-rust/vim-racer')
call dein#add('rust-lang/rust.vim')
call dein#add('scrooloose/syntastic')

" Pythonでお世話になる方々
call dein#add('scrooloose/syntastic')
call dein#add('yhat/vim-docstring')
call dein#add('heavenshell/vim-pydocstring')

" LaTeXを書きたいときはこれ
call dein#add('lervag/vimtex')
call dein#add('thinca/vim-quickrun')

" MarkDownを書きたいときはこれ
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')

" snippetを使う（最新版）
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
" call dein#add('SirVer/ultisnips')
" call dein#add('honza/vim-snippets')

call dein#end()

" 読み込んだプラグインも含め、
" ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化
filetype plugin indent on
filetype indent on
" syntax on

" インストールのチェック
if dein#check_install()
  call dein#install()
endif
"-----------------------------
" End Dein Settings.
"-----------------------------

