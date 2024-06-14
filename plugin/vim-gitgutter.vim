""""""""""""""""""""""""""""""
" Plug: 'airblade/vim-gitgutter'
""""""""""""""""""""""""""""""
" let g:gitgutter_diff_args='--cached'
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
