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
exe 'set runtimepath+=' .  g:VIM_DOTFILES_ROOT_DIR . '/.vim/dein/repos/github.com/Shougo/dein.vim'

let s:dein_dir = expand(g:VIM_DOTFILES_ROOT_DIR . '/.vim/dein')
let s:dein_toml_dir = expand(g:VIM_DOTFILES_ROOT_DIR . '/rc/plugins')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Load TOML
  let s:dein_toml = s:dein_toml_dir . '/dein.toml'
  let s:dein_lazy_toml = s:dein_toml_dir . '/dein_lazy.toml'

  call dein#load_toml(s:dein_toml)
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()

  " 読み込んだプラグインも含め、
  " ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化
  filetype plugin indent on
  filetype indent on
  " syntax on

  " インストールのチェック
  if dein#check_install()
    call dein#install()
  endif
endif

