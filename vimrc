scriptencoding utf-8
" 上記はUTF-8を利用する際に必須行

""
" Character_code_changing:
"   :e ++enc=utf-8
"   :set fileencoding=euc-jp
"   :w
"    (utf-8, euc-jp, shift_jis, japan, iso-2022-jp, cp932, unicode, etc)
"   Japanese description
"     最初に文字コードを文字化けしないものに変える
"     次に変えたい文字コードにセット
"     そして上書きすれば完璧

""
" File_format_changing:
"   :set ff=dos
"    (dos, mac, unix)
"   Japanese description
"     dosでWindowsの形式に改行を変更する
"     macでMac、unixでUNIXの形式に改行を変更する
"     要するにファイルフォーマット変更は改行の変更ってことかな

""
" Newline_character_changing:
"   .vimrcの改行コードがUNIXとなっていない、例えばwindowsで作成した.vimrcを転送
"   した場合、vim起動時にエラーとなることがある
"     $HOME$/.vimrcの処理中にエラーが検出されました:
"     行1:
"     E474: 無効な引数です: encoding=utf-8^M
"     行    3:
"     E474: 無効な引数です: fileformats=unix,dox,mac^M
"     続けるにはENTERを押すかコマンドを入力してください
"   これを防ぐにはvimで.vimrcを開いて以下のコマンドで改行ゴードを変換する
"   :setl ff=unix
"   :wq
"   または、-dオプションを用いて.vimrcファイルを開き、次のコマンドを実行する
"   :%s/^M//g
"   なお、^Mは<C-v><C-M>と入力する

""
" ColorScheme_setting:
"   カラースキーマを確認する
"   :colorscheme
"   ハイライトグループ一覧詳細
"   :highlight
"   更に詳細
"   :verbose highlight
"   https://qiita.com/shuhei/items/5ff5e9792746c70ab8ad
"
"   カーソル下のシンタックス情報取得
"   :SyntaxInfo
"   http://cohama.hateblo.jp/entry/2013/08/11/020849
"
"   設定可能カラー確認（エイリアス設定済み）
"   :Colortest
"   https://qiita.com/omega999/items/15031eece4256eb500e7
"
"   設定可能カラー確認
"   :XtermColorTable

""
" Clipboard_with_WSL: WSL (Bash on Ubuntu on Windows) でのクリップボード共有
"   fakeclipを使えばできるらしいけど、実際はできなかった
"   Windows側でVcXsrvを実行し、WSL側でbashrcに `export DISPLAY=localhost:0.0`
"   を追加すればよい

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Knowledge: 知っておくべきコマンドやキーマッピングたち
" <ESC><ESC> 文末のスペースキーを消す
" <C--><C--> コメントアウトする
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein: dein 導入方法 (vim7.4以降で使える)
" $ mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
" $ git clone https://github.com/Shougo/dein.vim.git \
"     ~/.vim/dein/repos/github.com/Shougo/dein.vim
"
"------------------------------------------------------------
" せっかく導入方法が理解できてアレなんだけど...以下は導入しても使わないよ
"
" NeoBundle 導入方法
" $ mkdir -p ~/.vim/bundle
" $ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
" （上記がだめだったら下記の通り）
" $ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
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

" Referenced from http://cohama.hateblo.jp/entry/2013/08/11/020849
" :SyntaxInfo
" to get the syntax info

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
  return {"name": name, "ctermfg": ctermfg, "ctermbg": ctermbg, "guifg": guifg, "guibg": guibg}
endfunction

function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name . " ctermfg: " . baseSyn.ctermfg . " ctermbg: " . baseSyn.ctermbg . " guifg: " . baseSyn.guifg . " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name . " ctermfg: " . linkedSyn.ctermfg . " ctermbg: " . linkedSyn.ctermbg . " guifg: " . linkedSyn.guifg . " guibg: " . linkedSyn.guibg
endfunction

command! SyntaxInfo call s:get_syn_info()

" end SyntaxInfo




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



"-----------------------------
" KaoriYa Vimrc
"-----------------------------

" plugins下のディレクトリをruntimepathへ追加する。
" for s:path in split(glob($VIM.'/plugins/*'), '\n')
"   if s:path !~# '\~$' && isdirectory(s:path)
"     let &runtimepath = &runtimepath.','.s:path
"   end
" endfor
" unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
" source $VIM/plugins/kaoriya/encode_japan.vim
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

" " vimdoc-ja: 日本語ヘルプを無効化する.
" if kaoriya#switch#enabled('disable-vimdoc-ja')
"   let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
" endif
"
" " vimproc: 同梱のvimprocを無効化する
" if kaoriya#switch#enabled('disable-vimproc')
"   let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
" endif
"
" " go-extra: 同梱の vim-go-extra を無効化する
" if kaoriya#switch#enabled('disable-go-extra')
"   let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
" endif
"-----------------------------
" End KaoriYa Vimrc
"-----------------------------



"""""""""""""""""""""
" コマンド群
"""""""""""""""""""""
command FW FixWhitespace
command Colortest so $VIMRUNTIME/syntax/colortest.vim

"""""""""""""""""""""
" コードマッピング群
"""""""""""""""""""""
" 表示上の行移動と実際の行移動を入れ替え
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" 文字検索したらハイライトつけたい
set hlsearch
" 文字検索した後のハイライトを消したい
nnoremap <ESC><ESC> :noh<CR>
" tree表示が長ったらしいから省略
nnoremap <C-t> :NERDTree<CR>
nnoremap s <Nop>
" fakeclip用簡易コマンド（動作しなかったためコメントアウト）
" nnoremap <silent> <Space>y "*Y
" vnoremap <silent> <Space>y "*Y
" nnoremap <silent> <Space>p "*P
" vnoremap <silent> <Space>p "*P
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
" terminalコマンドの利便性向上
nnoremap sh :belowright :terminal<CR>
nnoremap vsh :vertical :terminal<CR>
nnoremap bash :belowright :terminal ubuntu<CR>
nnoremap vbash :belowright :terminal ubuntu<CR>
nnoremap termp :belowright :terminal powershell<CR>
nnoremap vtermp :vertical :terminal powershell<CR>
tnoremap <C-A> <C-W>N:set nonumber<CR>:set nornu<CR>:set colorcolumn=0<CR>
" Terminal-Jobモード時にタブキーを入力すると強制的に <C-I> が入力されたことになる
" tnoremap <C-I> <C-W>N:set nonumber<CR>:set nornu<CR>:set colorcolumn=0<CR>
tnoremap <C-P> <C-W>""
tnoremap <C-q> <C-\><C-n>:q!<CR>
" nnoremap <ESC> :q!<CR> " 全てのノーマルモードで実行されてしまう
nnoremap <RightMouse> p

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
let colorSchemeList = 5
set termguicolors

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
  " autocmd ColorScheme * highlight Normal ctermbg=none
  " autocmd ColorScheme * highlight vimGroup ctermfg=4 ctermbg=0
  " autocmd ColorScheme * highlight perlHereDoc ctermbg=none
  " autocmd ColorScheme * highlight perlVarPlain ctermbg=none
  " autocmd ColorScheme * highlight perlStatementFileDesc ctermbg=none
  " autocmd ColorScheme * highlight texStatement ctermbg=none
  " autocmd ColorScheme * highlight texMathZoneX ctermbg=none
  " autocmd ColorScheme * highlight texMathMatcher ctermbg=none
  " autocmd ColorScheme * highlight texRefLabel ctermbg=none
  " autocmd ColorScheme * highlight rubyDefine ctermbg=none
  " autocmd ColorScheme * highlight Comment ctermfg=7 ctermbg=14 guibg=Gray
  " autocmd ColorScheme * highlight ColorColumn ctermfg=0 ctermbg=4
  " 選択時を変更
  " autocmd ColorScheme * highlight Visual ctermfg=0 ctermbg=14
  " autocmd ColorScheme * highlight Search ctermfg=0 ctermbg=4
  " autocmd ColorScheme * highlight IncSearch ctermfg=0 ctermbg=4
  " Perlの文をちょっと変える
  " autocmd ColorScheme * highlight perlString ctermfg=1
  " " autocmd ColorScheme * highlight perlComment ctermfg=0
  " " vimrcの文もちょっと変える
  " " autocmd ColorScheme * highlight vimIsCommand ctermfg=0

  let g:solarized_termtrans=1
  set background=dark
  try
    colorscheme solarized
    set termguicolors
  catch
  endtry

elseif colorSchemeList == 2
  " 選択時を変更
  autocmd ColorScheme * highlight Visual ctermfg=16 ctermbg=253
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

elseif colorSchemeList == 5
  " gruvbox https://github.com/morhetz/gruvbox/wiki/Terminal-specific
  " From: https://wonderwall.hatenablog.com/entry/2019/02/25/224719
  autocmd ColorScheme * highlight vimCommentTitle ctermfg=white guifg=white
  autocmd ColorScheme * highlight Comment ctermfg=229 ctermbg=237 guifg='#fbf1c7' guibg='#3c3836'
  autocmd ColorScheme * highlight Todo ctermfg=lightcyan guifg=lightcyan guibg=darkcyan
  autocmd ColorScheme * highlight podCommand ctermfg=white guibg='#eaf4fc' guifg='#203744'
  autocmd ColorScheme * highlight podCmdText ctermfg=white guifg='#e0ebaf'
  autocmd ColorScheme * highlight link perlPod GruvboxOrange
  autocmd ColorScheme * highlight link pythonDocstring GruvboxGray
  autocmd ColorScheme * highlight LineNr ctermfg=darkgreen guifg='#afafb0' ctermbg=black guibg='#060606'

  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,ColorScheme * highlight NonText ctermfg=lightgray guifg=lightgray
  autocmd VimEnter,ColorScheme * highlight SpecialKey ctermfg=lightgray guifg=lightgray
  autocmd VimEnter,Colorscheme * highlight IndentGuidesOdd ctermfg=lightgray guifg=lightgray guibg='#485859' ctermbg=darkgray
  autocmd VimEnter,Colorscheme * highlight IndentGuidesEven ctermfg=lightgray guifg=lightgray guibg='#16160e' ctermbg=darkgray

  let g:gruvbox_italic=1
  set bg=dark
  colorscheme gruvbox

elseif colorSchemeList == 6
  set background=dark
  colorscheme monokai_pro

endif

" let g:lightline = { 'colorsheme': 'one', }



" 文字コード固定と自動判定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

" 行番号を左に表示
set number
set relativenumber
" 行番号の色設定
" if colorSchemeList == 0
"     hi LineNr ctermfg=1
"     hi CursorLineNr ctermbg=2 ctermfg=0
" elseif colorSchemeList == 1
"     hi LineNr ctermbg=11 ctermfg=0
"     hi CursorLineNr ctermbg=6 ctermfg=0
" endif
" set cursorline " 行番号だけの色変更ができなかったため全体をコメントアウト
" hi CursorLine gui=underline guifg=NONE guibg=NONE cterm=underline ctermfg=NONE ctermbg=NONE
" hi clear CursorLineNr term=bold cterm=NONE ctermfg=1 ctermbg=NONE

" 81行目以降の色を変える
execute "set colorcolumn=" . join(range(81, 999), ',')

" tabキーの変更
" set noexpandtab "タブ入力を複数の空白入力に置き換えない
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
" vimでPythonを書くときにやっておきたいこと
"--------------------------------------------------"
let g:syntastic_python_checkers = ["flake8"]

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" docstring
autocmd BufNewFile,BufRead *.py syntax match pythonDocstring /"""\_.\{-}"""/ contains=pythonSpaceError,pythonDoctest,@Spell
autocmd BufNewFile,BufRead *.py syntax match pythonDocstring /'''\_.\{-}'''/ contains=pythonSpaceError,pythonDoctest,@Spell

" vim-docstring（docstringを折りたためる）
autocmd FileType python PyDocHide

" vim-pydocstring（docstringのテンプレを出力する）
let g:pydocstring_templates_dir = '~/.vim/dein/repos/github.com/heavenshell/vim-pydocstring/test/templates/numpy/'

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
    let g:TexPdfViewCommand = '!start ' . texPdfFilename
  endif
  if has('unix')
    let g:TexPdfViewCommand = ':! ' . 'evince' . texPdfFilename
  endif
  execute g:TexPdfViewCommand
endfunction



"--------------------------------------------------"
" vimでMarkDownを書くときにやっておきたいこと
"--------------------------------------------------"
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a chrome'



"--------------------------------------------------"
" vimで.vimrcを書くときにやっておきたいこと
"--------------------------------------------------"
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.vimrc setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=999,999
augroup END



"--------------------------------------------------"
" 業務でVimを利用する際にやっておきたいこと
"--------------------------------------------------"
set list listchars=tab:>-



"   ___  __)                  )   ___                  ______)
"  (,  |/                    (__/_____)   /)          (, /      /)  /)
"      |  _/_  _  __  ____     /      ___// _____       /  _   (/_ //  _
"   ) /|_ (___(/_/ (_/ / /_   /      (_)(/_(_)/ (_   ) /  (_(_/_) (/__(/_
"  (_/                       (______)               (_/
"
"                                                 guns <self@sungpae.com>

" Version:  1.6
" License:  MIT
" Homepage: http://github.com/guns/xterm-color-table.vim
"
" NOTES:
"
"   * Provides command :XtermColorTable, as well as variants for different splits
"   * Xterm numbers on the left, equivalent RGB values on the right
"   * Press `#` to yank current color (shortcut for yiw)
"   * Press `t` to toggle RGB text visibility
"   * Press `f` to set RGB text to current color
"   * Buffer behavior similar to Scratch.vim
"
" INSPIRED BY:
"
"   * http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
"   * http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"   * http://www.vim.org/scripts/script.php?script_id=664

" We have a dependency on buffer-local autocommands
if version < 700
  echo 'FAIL: XtermColorTable requires vim 7.0+'
  finish
endif

let s:bufname = '__XtermColorTable__'

if !exists('g:XtermColorTableDefaultOpen')
  let g:XtermColorTableDefaultOpen = 'split'
endif

command! XtermColorTable  call <SID>XtermColorTable()
command! SXtermColorTable call <SID>XtermColorTable('split')
command! VXtermColorTable call <SID>XtermColorTable('vsplit')
command! TXtermColorTable call <SID>XtermColorTable('tabnew')
command! EXtermColorTable call <SID>XtermColorTable('edit')
command! OXtermColorTable call <SID>XtermColorTable('edit') | only

augroup XtermColorTable
  autocmd!
  autocmd BufNewFile  __XtermColorTable__ call <SID>ColorTable()
  autocmd ColorScheme *                   silent! doautoall XtermColorTableBuffer ColorScheme
augroup END

function! s:XtermColorTable(...)
  let bufid = bufnr(s:bufname)
  let winid = bufwinnr(bufid)
  let open = a:0 ? a:1 : g:XtermColorTableDefaultOpen

  if bufid == -1
    " Create new buffer
    execute open . ' ' . s:bufname
    return
  elseif winid != -1 && winnr('$') > 1
    " Close extant window
    execute winid . 'wincmd w' | close
  endif

  " Open extant buffer
  execute open . ' +buffer' . bufid
endfunction

function! s:ColorTable()
  let rows = []

  call add(rows, s:ColorRow(0,  7))
  call add(rows, s:ColorRow(8, 15))
  call add(rows, '')

  for lnum in range(16, 250, 6)
    call add(rows, s:ColorRow(lnum, lnum + 5))
    if lnum == 226
      call add(rows, '')
    endif
  endfor

  if &modifiable
    call append(0, rows)
    call append(len(rows) + 1, s:HelpComment())
    call s:SetBufferOptions()
  endif
endfunction

function! s:ColorRow(start, end)
  return join(map(range(a:start, a:end), 's:ColorCell(v:val)'))
endfunction

function! s:ColorCell(n)
  let rgb = s:xterm_colors[a:n]

  " Clear extant values
  execute 'silent! syntax clear fg_' . a:n
  execute 'silent! syntax clear bg_' . a:n

  execute 'syntax match fg_' . a:n . ' " ' . a:n . ' " containedin=ALL'
  execute 'syntax match bg_' . a:n . ' "'  . rgb . '" containedin=ALL'

  call s:HighlightCell(a:n, -1)

  return printf(' %3s %7s', a:n, rgb)
endfunction

function! s:HighlightCell(n, bgf)
  let rgb = s:xterm_colors[a:n]

  " bgf has three states:
  "   -2) black or white depending on intensity
  "   -1) same as background
  "   0+) xterm color value
  if a:bgf == -2
    let sum = 0
    for val in map(split(substitute(rgb, '^#', '', ''), '\v\x{2}\zs'), 'str2nr(v:val, 16)')
      " TODO: does Vimscript have a fold/reduce function?
      let sum += val
    endfor
    let bgf = sum > (0xff * 1.5) ? 0 : 15
  elseif a:bgf == -1
    let bgf = a:n
  else
    let bgf = a:bgf
  endif

  " Clear any extant values
  execute 'silent! highlight clear fg_' . a:n
  execute 'silent! highlight clear bg_' . a:n

  execute 'highlight fg_' . a:n . ' ctermfg=' . a:n . ' guifg=' . rgb
  execute 'highlight bg_' . a:n . ' ctermbg=' . a:n . ' guibg=' . rgb
  execute 'highlight bg_' . a:n . ' ctermfg=' . bgf . ' guifg=' . s:xterm_colors[bgf]
endfunction

function! s:SetBufferOptions()
  setlocal buftype=nofile bufhidden=hide buflisted
  setlocal nomodified nomodifiable noswapfile readonly
  setlocal nocursorline nocursorcolumn
  setlocal iskeyword+=#
  setlocal nospell

  let b:XtermColorTableRgbVisible = 0
  let b:XtermColorTableBGF = -2

  nmap <silent><buffer> # yiw:echo 'yanked: ' . @"<CR>
  nmap <silent><buffer> t :call <SID>ToggleRgbVisibility()<CR>
  nmap <silent><buffer> f :call <SID>SetRgbForeground(expand('<cword>'))<CR>

  " Colorschemes often call `highlight clear';
  " register a handler to deal with this
  augroup XtermColorTableBuffer
    autocmd! * <buffer>
    autocmd ColorScheme <buffer> call s:HighlightTable(-1)
  augroup END
endfunction

function! s:HelpComment()
  " we have to define our own comment type
  silent! syntax clear XtermColorTableComment
  syntax match XtermColorTableComment ';.*'
  highlight link XtermColorTableComment Comment

  let lines = []
  call add(lines, "; # to copy current color (yiw)")
  call add(lines, "; t to toggle RGB visibility")
  call add(lines, "; f to set RGB foreground color")

  return lines
endfunction

function! s:ToggleRgbVisibility()
  let bgf = b:XtermColorTableRgbVisible ? -1 : b:XtermColorTableBGF
  let b:XtermColorTableRgbVisible = (b:XtermColorTableRgbVisible + 1) % 2

  call s:HighlightTable(bgf)
endfunction

function! s:HighlightTable(bgf)
  for val in range(0, 0xff) | call s:HighlightCell(val, a:bgf) | endfor
endfunction

function! s:SetRgbForeground(cword)
  if len(a:cword)
    let sname = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let b:XtermColorTableBGF = substitute(sname, '\v^\w+_', '', '') + 0
  else
    let b:XtermColorTableBGF = -2
  endif

  if b:XtermColorTableRgbVisible
    call s:HighlightTable(b:XtermColorTableBGF)
  else
    call s:ToggleRgbVisibility()
  endif
endfunction

""" Xterm 256 color dictionary

let s:xterm_colors = {
  \ '0':   '#000000', '1':   '#800000', '2':   '#008000', '3':   '#808000', '4':   '#000080',
  \ '5':   '#800080', '6':   '#008080', '7':   '#c0c0c0', '8':   '#808080', '9':   '#ff0000',
  \ '10':  '#00ff00', '11':  '#ffff00', '12':  '#0000ff', '13':  '#ff00ff', '14':  '#00ffff',
  \ '15':  '#ffffff', '16':  '#000000', '17':  '#00005f', '18':  '#000087', '19':  '#0000af',
  \ '20':  '#0000df', '21':  '#0000ff', '22':  '#005f00', '23':  '#005f5f', '24':  '#005f87',
  \ '25':  '#005faf', '26':  '#005fdf', '27':  '#005fff', '28':  '#008700', '29':  '#00875f',
  \ '30':  '#008787', '31':  '#0087af', '32':  '#0087df', '33':  '#0087ff', '34':  '#00af00',
  \ '35':  '#00af5f', '36':  '#00af87', '37':  '#00afaf', '38':  '#00afdf', '39':  '#00afff',
  \ '40':  '#00df00', '41':  '#00df5f', '42':  '#00df87', '43':  '#00dfaf', '44':  '#00dfdf',
  \ '45':  '#00dfff', '46':  '#00ff00', '47':  '#00ff5f', '48':  '#00ff87', '49':  '#00ffaf',
  \ '50':  '#00ffdf', '51':  '#00ffff', '52':  '#5f0000', '53':  '#5f005f', '54':  '#5f0087',
  \ '55':  '#5f00af', '56':  '#5f00df', '57':  '#5f00ff', '58':  '#5f5f00', '59':  '#5f5f5f',
  \ '60':  '#5f5f87', '61':  '#5f5faf', '62':  '#5f5fdf', '63':  '#5f5fff', '64':  '#5f8700',
  \ '65':  '#5f875f', '66':  '#5f8787', '67':  '#5f87af', '68':  '#5f87df', '69':  '#5f87ff',
  \ '70':  '#5faf00', '71':  '#5faf5f', '72':  '#5faf87', '73':  '#5fafaf', '74':  '#5fafdf',
  \ '75':  '#5fafff', '76':  '#5fdf00', '77':  '#5fdf5f', '78':  '#5fdf87', '79':  '#5fdfaf',
  \ '80':  '#5fdfdf', '81':  '#5fdfff', '82':  '#5fff00', '83':  '#5fff5f', '84':  '#5fff87',
  \ '85':  '#5fffaf', '86':  '#5fffdf', '87':  '#5fffff', '88':  '#870000', '89':  '#87005f',
  \ '90':  '#870087', '91':  '#8700af', '92':  '#8700df', '93':  '#8700ff', '94':  '#875f00',
  \ '95':  '#875f5f', '96':  '#875f87', '97':  '#875faf', '98':  '#875fdf', '99':  '#875fff',
  \ '100': '#878700', '101': '#87875f', '102': '#878787', '103': '#8787af', '104': '#8787df',
  \ '105': '#8787ff', '106': '#87af00', '107': '#87af5f', '108': '#87af87', '109': '#87afaf',
  \ '110': '#87afdf', '111': '#87afff', '112': '#87df00', '113': '#87df5f', '114': '#87df87',
  \ '115': '#87dfaf', '116': '#87dfdf', '117': '#87dfff', '118': '#87ff00', '119': '#87ff5f',
  \ '120': '#87ff87', '121': '#87ffaf', '122': '#87ffdf', '123': '#87ffff', '124': '#af0000',
  \ '125': '#af005f', '126': '#af0087', '127': '#af00af', '128': '#af00df', '129': '#af00ff',
  \ '130': '#af5f00', '131': '#af5f5f', '132': '#af5f87', '133': '#af5faf', '134': '#af5fdf',
  \ '135': '#af5fff', '136': '#af8700', '137': '#af875f', '138': '#af8787', '139': '#af87af',
  \ '140': '#af87df', '141': '#af87ff', '142': '#afaf00', '143': '#afaf5f', '144': '#afaf87',
  \ '145': '#afafaf', '146': '#afafdf', '147': '#afafff', '148': '#afdf00', '149': '#afdf5f',
  \ '150': '#afdf87', '151': '#afdfaf', '152': '#afdfdf', '153': '#afdfff', '154': '#afff00',
  \ '155': '#afff5f', '156': '#afff87', '157': '#afffaf', '158': '#afffdf', '159': '#afffff',
  \ '160': '#df0000', '161': '#df005f', '162': '#df0087', '163': '#df00af', '164': '#df00df',
  \ '165': '#df00ff', '166': '#df5f00', '167': '#df5f5f', '168': '#df5f87', '169': '#df5faf',
  \ '170': '#df5fdf', '171': '#df5fff', '172': '#df8700', '173': '#df875f', '174': '#df8787',
  \ '175': '#df87af', '176': '#df87df', '177': '#df87ff', '178': '#dfaf00', '179': '#dfaf5f',
  \ '180': '#dfaf87', '181': '#dfafaf', '182': '#dfafdf', '183': '#dfafff', '184': '#dfdf00',
  \ '185': '#dfdf5f', '186': '#dfdf87', '187': '#dfdfaf', '188': '#dfdfdf', '189': '#dfdfff',
  \ '190': '#dfff00', '191': '#dfff5f', '192': '#dfff87', '193': '#dfffaf', '194': '#dfffdf',
  \ '195': '#dfffff', '196': '#ff0000', '197': '#ff005f', '198': '#ff0087', '199': '#ff00af',
  \ '200': '#ff00df', '201': '#ff00ff', '202': '#ff5f00', '203': '#ff5f5f', '204': '#ff5f87',
  \ '205': '#ff5faf', '206': '#ff5fdf', '207': '#ff5fff', '208': '#ff8700', '209': '#ff875f',
  \ '210': '#ff8787', '211': '#ff87af', '212': '#ff87df', '213': '#ff87ff', '214': '#ffaf00',
  \ '215': '#ffaf5f', '216': '#ffaf87', '217': '#ffafaf', '218': '#ffafdf', '219': '#ffafff',
  \ '220': '#ffdf00', '221': '#ffdf5f', '222': '#ffdf87', '223': '#ffdfaf', '224': '#ffdfdf',
  \ '225': '#ffdfff', '226': '#ffff00', '227': '#ffff5f', '228': '#ffff87', '229': '#ffffaf',
  \ '230': '#ffffdf', '231': '#ffffff', '232': '#080808', '233': '#121212', '234': '#1c1c1c',
  \ '235': '#262626', '236': '#303030', '237': '#3a3a3a', '238': '#444444', '239': '#4e4e4e',
  \ '240': '#585858', '241': '#606060', '242': '#666666', '243': '#767676', '244': '#808080',
  \ '245': '#8a8a8a', '246': '#949494', '247': '#9e9e9e', '248': '#a8a8a8', '249': '#b2b2b2',
  \ '250': '#bcbcbc', '251': '#c6c6c6', '252': '#d0d0d0', '253': '#dadada', '254': '#e4e4e4',
  \ '255': '#eeeeee', 'fg': 'fg', 'bg': 'bg', 'NONE': 'NONE' }
