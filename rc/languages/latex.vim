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

