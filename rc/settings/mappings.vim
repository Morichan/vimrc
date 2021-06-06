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

" empty-prompt.vimプラグインでは利用が難しいスクリプト判定を追加する
" https://tyru.hatenablog.com/entry/2020/01/06/152929
function! s:is_empty_prompt()
  return (&shell =~# 'sh$'
    \ ? term_getline(bufnr(''), '.') =~# '❯ $'
    \   || term_getline(bufnr(''), '.') =~# '\$ $'
    \   || term_getline(bufnr(''), '.') =~# '% $'
    \   || term_getline(bufnr(''), '.') =~# '# $'
    \ : term_getline(bufnr(''), '.') =~# '> $')
endfunction
tnoremap <expr>:     <SID>is_empty_prompt() ? "\<C-w>:" : ':'
tnoremap <expr><ESC> <SID>is_empty_prompt() ? "\<C-w>N" : "<ESC>"

""
" Tips:コマンドは:wqのwq部分を別の入力に変更する
"      コードマッピングはj（下に移動）を別の入力に変更する
"      つまりコードマッピングはコマンドの上位互換

