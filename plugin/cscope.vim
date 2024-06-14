""""""""""""""""""""""""""""""
" Vundle:cscope
""""""""""""""""""""""""""""""
function! AddScope()
    " set csprg=/usr/local/bin/cscope
    " set cscopetagorder=1
    " set cscopetag
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endfunction

function! GenerateScope()
  call system('find . ! -path .git ! -type l -name "*.[ch]" -print >cscope.files')
  call system('find . ! -path .git ! -type l -name "*.cpp" -print >>cscope.files')
  call system('find . ! -path .git ! -type l -name "*.cc" -print >>cscope.files')
  call system('cscope -bkq -i cscope.files')
  call AddScope()
endfunction

command! Cscope call GenerateScope()

if has("cscope")
" use quickfix window instead of default way
set cscopequickfix=s-,c-,d-,i-,t-,e-,g-

" autoloading cscope database
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()
endif

" cscope bindings
"   's' symbol: find all references to the token under cursor
"   'g' global: find global definition(s) of the token under cursor
"   'c' calls:  find all calls to the function name under cursor
"   't' text:   find all instances of the text under cursor
"   'e' egrep:  egrep search for the word under cursor
"   'f' file:   open the filename under cursor
"   'i' includes: find files that include the filename under cursor
"   'd' called: find functions that function under cursor calls
"   'a' assignments: find places where this symbol is assigned a value
"   'S' struct: find struct definition under cursor
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>:copen<cr>
" nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>se :cs find e 
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>:copen<cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>so :copen<cr>

function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--delimiter', ':', '--preview-window', '+{2}-/2']
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

nnoremap <silent> <Leader>ya :call Cscope('0', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yc :call Cscope('1', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yd :call Cscope('2', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ye :call Cscope('3', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yf :call Cscope('4', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yg :call Cscope('6', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yi :call Cscope('7', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ys :call Cscope('8', expand('<cword>'))<CR>
nnoremap <silent> <Leader>yt :call Cscope('9', expand('<cword>'))<CR>
