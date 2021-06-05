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
