""""""""""""""""""""""""""""""
" Vundle:NerdTree
""""""""""""""""""""""""""""""
" Auto work when opening
"autocmd VimEnter * NERDTree

" Set windoe position
let NERDTreeWinPos="right"

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=1

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
       if winnr("$") == 1
          q
       endif
    endif
  endif
endfunction

map <F9> :NERDTreeToggle<CR>
