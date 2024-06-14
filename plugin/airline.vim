""""""""""""""""""""""""""""""
" Vundle:airline
""""""""""""""""""""""""""""""
if has("gui_running")
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'
else
  let g:airline_theme='luna'
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
