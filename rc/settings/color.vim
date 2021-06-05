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



""""""""""""""""""""""""""""""
" カラースキーマ変更群
""""""""""""""""""""""""""""""
" -- solarized personal conf
" light背景色は RGB=fcf4e4=252,244,228
" dark背景色は RGB=7,54,66
syntax enable
" console2 solalized light=0, dark=1, default solarized light=3, dark=4
" molokai=2
set termguicolors

" luochen1990/rainbow 有効化
let g:rainbow_active = 1

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

