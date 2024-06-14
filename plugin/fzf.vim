""""""""""""""""""""""""""""""
" Plug: fzf.vim
""""""""""""""""""""""""""""""
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" command :Ag redefine
command! -bang -nargs=* AG call fzf#vim#ag(<q-args>, "-s --word-regexp", fzf#vim#with_preview(), <bang>0)
" keymaps
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :AG <C-R><C-W><CR>
