" 文字コード固定と自動判定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

" 行番号を左に表示
set number
" set relativenumber

" tabキーの変更
" set noexpandtab "タブ入力を複数の空白入力に置き換えない
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してtabやバックスペースでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせ次行のインデントを増減
" tabキーをわかりやすく表示する
set list listchars=tab:>-

" スクロールする時に下が見えるようにする
set scrolloff=3
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" ビープ音を鳴らさない
set vb t_vb=

" 文字検索したらハイライトつけたい
set hlsearch
" 文字検索をリアルタイムに
set incsearch

" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" undoファイルを作らない（.ファイル名.un~ってやつ）
set noundofile

" スワップファイルを作成しない
set noswapfile

" lightline強制表示
set laststatus=2

" バックスペースで各種消せるようにする
set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" 対応括弧の表示秒数を3秒にする
set matchtime=1

" 文字がない場所にもカーソルを移動できるようにする
set virtualedit=all

" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase

" コマンド、検索パターンを10000個まで履歴に残す
set history=10000

" マウスモード有効
set mouse=a

" クリップボードにコピペできるようにする
set clipboard=unnamedplus,unnamed,autoselect

" xtermとscreen対応
set ttymouse=xterm2

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" YouCompleteMeインストール時のクラッシュ対応
let g:ycm_path_to_python_interpreter = 'C:/python-3.8.1-amd64/python3'

" ディレクトリが存在しない場合に生成するか確認する
" https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" directory does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" undoディレクトリ内に変更履歴を保存する
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  exe 'set undodir=' . undo_path
  set undofile
endif

