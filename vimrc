scriptencoding utf-8
" 上記はUTF-8を利用する際に必須行

""
" Character Code change
" :e ++enc=utf-8
" :set fileencoding=euc-jp
" :w
"  (utf-8, euc-jp, shift_jis, japan, iso-2022-jp, cp932, unicode, etc)
" Japanese description
"   最初に文字コードを文字化けしないものに変える
"   次に変えたい文字コードにセット
"   そして上書きすれば完璧

""
" File Format change
" :set ff=dos
"  (dos, mac, unix)
" Japanese description
"   dosでWindowsの形式に改行を変更する
"   macでMac、unixでUNIXの形式に改行を変更する
"   要するにファイルフォーマット変更は改行の変更ってことかな

""
" Newline character change
" .vimrcの改行コードがUNIXとなっていない、例えばwindowsで作成した.vimrcを転送
" した場合、vim起動時にエラーとなることがある
"   $HOME$/.vimrcの処理中にエラーが検出されました:
"   行1:
"   E474: 無効な引数です: encoding=utf-8^M
"   行    3:
"   E474: 無効な引数です: fileformats=unix,dox,mac^M
"   続けるにはENTERを押すかコマンドを入力してください
" これを防ぐにはvimで.vimrcを開いて以下のコマンドで改行ゴードを変換する
" :setl ff=unix
" :wq
" または、-dオプションを用いて.vimrcファイルを開き、次のコマンドを実行する
" :%s/^M//g
" なお、^Mは<C-v><C-M>と入力する

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 知っておくべきコマンドやキーマッピングたち
" <ESC><ESC> 文末のスペースキーを消す
" <C--><C--> コメントアウトする
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein 導入方法 (vim7.4以降で使える)
" $ mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
" $ git clone https://github.com/Shougo/dein.vim.git \
"     ~/.vim/dein/repos/github.com/Shougo/dein.vim
"
" NeoBundle 導入方法
" $ mkdir -p ~/.vim/bundle
" $ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
" （上記がだめだったら下記の通り）
" $ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"
"------------------------------------------------------------
" せっかく導入方法が理解できてアレなんだけど...以下は導入しても使わないよ
"
" Vundle 導入方法
" $ mkdir -p ~/.vim/vundle
" $ git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" plug 導入方法
" $ mkdir -p ~/.vim/autoload
" $ curl -fLo ~/.vim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" （上記は古いかもしれないので以下のようにする）
" 1. https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vimをブラ
"    ウザで開く
" 2. 名前をつけて保存する
" 3. ファイル名をPlug.vimに変更（拡張子を.vimにするという意味ね）
" 4. ~/.vim/autoload/ 直下にぶち込んで終わり
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction
""""""""""""""""""""""""""""""

function! s:get_syn_id(transparent)
    let synid = synID(line("."), col("."), 1)
    if a:transparent
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction
function! s:get_syn_attr(synid)
    let name = synIDattr(a:synid, "name")
    let ctermfg = synIDattr(a:synid, "fg", "cterm")
    let ctermbg = synIDattr(a:synid, "bg", "cterm")
    let guifg = synIDattr(a:synid, "fg", "gui")
    let guibg = synIDattr(a:synid, "bg", "gui")
    return {
    \ "name": name,
    \ "ctermfg": ctermfg,
    \ "ctermbg": ctermbg,
    \ "guifg": guifg,
    \ "guibg": guibg}
endfunction
function! s:get_syn_info()
    let baseSyn = s:get_syn_attr(s:get_syn_id(0))
    echo "name: " . baseSyn.name .
    \ " ctermfg: " . baseSyn.ctermfg .
    \ " ctermbg: " . baseSyn.ctermbg .
    \ " guifg: " . baseSyn.guifg .
    \ " guibg: " . baseSyn.guibg
    let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
    echo "link to"
    echo "name: " . linkedSyn.name .
    \ " ctermfg: " . linkedSyn.ctermfg .
    \ " ctermbg: " . linkedSyn.ctermbg .
    \ " guifg: " . linkedSyn.guifg .
    \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()



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
"  dein
"
" next generation of NeoBundle
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

" インデントに色を付けて見やすくする
call dein#add('nathanaelkane/vim-indent-guides')
" 行末の半角スペースを可視化
call dein#add('bronson/vim-trailing-whitespace')

" ファイルをtree表示してくれる
call dein#add('scrooloose/nerdtree')

" Perlで何かしてくれる？よくわからん
call dein#add('vim-perl/vim-perl')

" solarizedを使う
call dein#add('altercation/vim-colors-solarized')

" molokaiを使う
call dein#add('tomasr/molokai')

call dein#add('gmarik/vundle')

" Perlでお世話になる方々
call dein#add('petdance/vim-perl')
call dein#add('hotchpotch/perldoc-vim')

" Rustでお世話になる方々
call dein#add('racer-rust/vim-racer')
call dein#add('rust-lang/rust.vim')
call dein#add('scrooloose/syntastic')

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



"-----------------------------
" KaoriYa Vimrc
"-----------------------------

" plugins下のディレクトリをruntimepathへ追加する。
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
endif

" vimproc: 同梱のvimprocを無効化する
if kaoriya#switch#enabled('disable-vimproc')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
endif

" go-extra: 同梱の vim-go-extra を無効化する
if kaoriya#switch#enabled('disable-go-extra')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
endif
"-----------------------------
" End KaoriYa Vimrc
"-----------------------------



"""""""""""""""""""""
" コマンド群
"""""""""""""""""""""
command FW FixWhitespace

"""""""""""""""""""""
" コードマッピング群
"""""""""""""""""""""
" 表示上の行移動と実際の行移動を入れ替え
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" 文字検索した後のハイライトを消したい
nnoremap <ESC><ESC> :noh<CR>
" tree表示が長ったらしいから省略
nnoremap <C-t> :NERDTree<CR>
nnoremap s <Nop>
" 画面分割後のウィンドウの大きさ変更
call submode#enter_with('bufmove', 'n', '', 'sl', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 'sh', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 'sj', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 'sk', '<C-w>-')
call submode#map('bufmove', 'n', '', 'l', '<C-w>>')
call submode#map('bufmove', 'n', '', 'h', '<C-w><')
call submode#map('bufmove', 'n', '', 'j', '<C-w>+')
call submode#map('bufmove', 'n', '', 'k', '<C-w>-')
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

""
" Tips:コマンドは:wqのwq部分を別の入力に変更する
"      コードマッピングはj（下に移動）を別の入力に変更する
"      つまりコードマッピングはコマンドの上位互換


""""""""""""""""""""""""""""""
" カラースキーマ変更群
""""""""""""""""""""""""""""""
" -- solarized personal conf
" light背景色は RGB=fcf4e4=252,244,228
" dark背景色は RGB=7,54,66
syntax enable
" console2 solalized light=0, dark=1, default solarized light=3, dark=4
" molokai=2
let colorSchemeList = 1

""
" Tips:ハイライト変更はカラースキーマ設定の前に
" Tips:ctermの色の種類は16色、guiの色はRGB法

if colorSchemeList == 0
    """"""""""""""""""""""""""""""""""""""""""""""""""
    " カラースキーマ変更
    """"""""""""""""""""""""""""""""""""""""""""""""""
    autocmd ColorScheme * highlight vimGroup ctermfg=4 ctermbg=15
    autocmd ColorScheme * highlight Comment ctermfg=0
    autocmd ColorScheme * highlight Visual ctermfg=0 ctermbg=14
    autocmd ColorScheme * highlight Search ctermfg=0 ctermbg=4
    autocmd ColorScheme * highlight IncSearch ctermfg=0
    autocmd ColorScheme * highlight perlString ctermfg=0

    set background=light
    try
        colorscheme solarized
    catch
    endtry

elseif colorSchemeList == 1
    """"""""""""""""""""""""""""""""""""""""""""""""""
    " カラースキーマ変更
    """"""""""""""""""""""""""""""""""""""""""""""""""
    " 背景をコンソールの背景と同一色にし、異なる通常背景とも統一
    autocmd ColorScheme * highlight Normal ctermbg=none
    autocmd ColorScheme * highlight vimGroup ctermfg=4 ctermbg=0
    autocmd ColorScheme * highlight perlHereDoc ctermbg=none
    autocmd ColorScheme * highlight perlVarPlain ctermbg=none
    autocmd ColorScheme * highlight perlStatementFileDesc ctermbg=none
    autocmd ColorScheme * highlight texStatement ctermbg=none
    autocmd ColorScheme * highlight texMathZoneX ctermbg=none
    autocmd ColorScheme * highlight texMathMatcher ctermbg=none
    autocmd ColorScheme * highlight texRefLabel ctermbg=none
    autocmd ColorScheme * highlight rubyDefine ctermbg=none
    autocmd ColorScheme * highlight Comment ctermfg=7
    autocmd ColorScheme * highlight ColorColumn ctermfg=0 ctermbg=4
    " 選択時を変更
    autocmd ColorScheme * highlight Visual ctermfg=0 ctermbg=14
    autocmd ColorScheme * highlight Search ctermfg=0 ctermbg=4
    autocmd ColorScheme * highlight IncSearch ctermfg=0 ctermbg=4
    " Perlの文をちょっと変える
    autocmd ColorScheme * highlight perlString ctermfg=1
    " autocmd ColorScheme * highlight perlComment ctermfg=0
    " vimrcの文もちょっと変える
    " autocmd ColorScheme * highlight vimIsCommand ctermfg=0

    let g:solarized_termtrans=1
    set background=dark
    try
        colorscheme solarized
    catch
    endtry

elseif colorSchemeList == 2
    " colorscheme solarizeを使っているから、ここでは見なかったことに
    colorscheme molokai
    set t_Co=256

elseif colorSchemeList == 3
    let g:solarized_termtrans=1
    set background=light
    try
        colorscheme solarized
    catch
    endtry

elseif colorSchemeList == 4
    let g:solarized_termtrans=1
    set background=dark
    try
        colorscheme solarized
    catch
    endtry

endif



" 文字コード固定と自動判定
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" 行番号を左に表示
set number
" 行番号の色設定
if colorSchemeList == 0
    hi LineNr ctermfg=1
    hi CursorLineNr ctermbg=2 ctermfg=0
elseif colorSchemeList == 1
    hi LineNr ctermbg=11 ctermfg=0
    hi CursorLineNr ctermbg=6 ctermfg=0
endif
set cursorline
hi clear CursorLine

" 81行目以降の色を変える
execute "set colorcolumn=" . join(range(81, 999), ',')

" tabキーの変更
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してtabやバックスペースでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせ次行のインデントを増減

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

" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" undoファイルを作らない（.ファイル名.un~ってやつ）
set noundofile

" スワップファイルを作成しない
set noswapfile

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
set clipboard=unnamed,autoselect

" xtermとscreen対応
set ttymouse=xterm2

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1


"--------------------------------------------------"
" vimでPerlを書くときにやっておきたいこと（らしい
"--------------------------------------------------"
filetype plugin on

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {'perl' : '-R -h ".pm"'}

let g:neocomplcache_snippets_dir = "~/.vim/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {'default'    : '', 'perl'       : $HOME . '/.vim/dict/perl.dict'}


" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)



"--------------------------------------------------"
" vimでLaTeXを書くときにやっておきたいこと
"--------------------------------------------------"

" autocmd
"==============================
augroup filetype
    autocmd!
    " tex file (I always use latex)
    autocmd BufRead,BufNewFile *.tex setlocal filetype=tex
augroup END

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.tex setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END

let g:latex_latexmk_continuous = 1
let g:latex_latexmk_background = 1

let g:vimtex_fold_env = 0
let g:tex_conceal=''

let g:quickrun_config = {}
let g:quickrun_config['tex'] = {
            \   'command' : 'latexmk',
            \   'outputter' : 'error',
            \   'outputter/error/error' : 'quickfix',
            \   'cmdopt': '-pdfdvi',
            \   'exec': ['%c %o %s']
            \ }

augroup myLaTeXQuickrun
    au!
    au BufEnter *.tex call <SID>SetLaTeXMainSource()
    au BufEnter *.tex nnoremap <Leader>v :call <SID>TexPdfView() <CR>
augroup END
function! s:SetLaTeXMainSource()
    let currentFileDirectory = expand('%:p:h').'\'
    let latexmain = glob(currentFileDirectory.'*.latexmain')
    let g:quickrun_config['tex']['srcfile'] = fnamemodify(latexmain, ':r')
    if latexmain == ''
        unlet g:quickrun_config['tex']['srcfile']
    endif
endfunction
function! s:TexPdfView()
    let texPdfFilename = expand('%')
    if exists("g:quickrun_config['tex']['srcfile']")
        let texPdfFilename = fnamemodify(g:quickrun_config['tex']['srcfile'], ':.:r') . '.pdf'
    endif
    if has('win32')
        let g:TexPdfViewCommand = '!start '.
                    \             texPdfFilename
    endif
    if has('unix')
        let g:TexPdfViewCommand = ':! '.
                    \             'evince'.
                    \             texPdfFilename
    endif
    execute g:TexPdfViewCommand
endfunction



"--------------------------------------------------"
" vimでMarkDownを書くときにやっておきたいこと
"--------------------------------------------------"
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a chrome'

