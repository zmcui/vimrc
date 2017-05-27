""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" zongmin.cui
"
" Repository:
" https://github.com/zmcui/vimrc.git
"
" Version:
" 2015-01-13 12:17:12
"
" Section:
" => General
" => Vundle
" => VIM user interface
" => Colors and Fonts
" => Files, backups and undo
" => Text, tab and indent related
" => tabs, windows and buffers
" => quickfix
" => Status line
" => Editing mappings
" => Paired character
" => Timestamp
" => logcat
"
" => Vundle:NerdTree
" => Vundle:tagbar
" => Vundle:ctrlp
" => Vundle:YouCompleteMe
" => Vundle:ack.vim
" => Vundle:ag.vim
" => Vundle:cscope
" => Vundle:syntastic
" => Vundle:nerdcommenter
" => Vundle:a.vim
" => Vundle:supertab
" => Vundle:vim-autoclose
" => Vundle:vim-fugitive
"
" Description:
" This is the personal .vimrc file of zongmin.cui
"
""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible		        "Be iMproved
set history=1000	        	"Lines of history VIM has to remember
set showcmd                 "Show incomplete cmds down the bottom
set showmode                "Show current mode down the bottom

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :qa<cr>

" Auto-reload your vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" look for tags up and up
set tags=./tags,tags;$HOME

" using clipboard as the default register
set clipboard=unnamedplus

" search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle 
Plugin 'gmarik/vundle'        " required!
" original repos on github
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/a.vim'
Plugin 'ervandew/supertab'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Logcat-syntax-highlighter'

filetype plugin indent on     " required!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 9 lines to the cursor - when moving vertically using j/k
set so=9
" Turn on the WiLd menu
set wildmenu
" Line number
set nu
" Ignore case when searching...
set ignorecase
" ...unless we type a capital
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Cursorline
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kick vim to recognize 256-colors modern terminals
if $COLORTERM == "gnome-terminal" || $TERM == "xterm-256color" || $TERM == "screen-256color"
  set t_Co=256
endif

" Enable syntax highlighting
syntax enable 

try
    colorscheme desert
catch
endtry

set background=dark


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
"set expandtab
" Be smart when using tabs
set smarttab
" 1 tab == 2 spaces
"set shiftwidth=2
"set tabstop=2
"Auto indent
set ai
"Smart indent
set si
"Wrap lines(default on)
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open new tab page in quickfix window results
set switchbuf+=usetab,newtab

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


""""""""""""""""""""""""""""""
" => quickfix
""""""""""""""""""""""""""""""
" Automatically close the quick fix window when leaving a file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Automatically fitting a quickfix window height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Paired character 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you type an open brace, a closing brace is automatically inserted on
" the same line after the cursor
" If you quickly press Enter after the open brace (to begin a code block), the
" closing brace will be inserted on the line below the cursor
" inoremap {      {}<Left>
" inoremap {<CR>  {<CR>}<Esc>O
" inoremap {{     {
" inoremap {}     {}
" "
" inoremap (      ()<Left>
" inoremap [      []<Left>
" inoremap []     []
" "
inoremap /*          /**/<Left><Left>
inoremap /*<Space>   /*<Space><Space>*/<Left><Left><Left>
inoremap /*<CR>      /*<CR>*/<Esc>O
inoremap <Leader>/*  /*
"
" inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"


""""""""""""""""""""""""""""""
" => Timestamp 
""""""""""""""""""""""""""""""
"insert timestamp using "xtime" in insert mode
"RFC822 format:%a, %d %b %Y %H:%M:%S %z   Wed, 29 Aug 2007 02:37:15 -0400
iab xtime <c-r>=strftime("%d-%m-%y %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%a, %d %b %Y %H:%M:%S %z")<cr>


""""""""""""""""""""""""""""""
" Vundle:NerdTree
""""""""""""""""""""""""""""""
map <F9> :NERDTreeToggle<CR>

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


""""""""""""""""""""""""""""""
" Vundle:tagbar
""""""""""""""""""""""""""""""
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_sort = 0

""""""""""""""""""""""""""""""
" Vundle:ctrlp
""""""""""""""""""""""""""""""
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

""""""""""""""""""""""""""""""
" Vundle:YouCompleteMe
""""""""""""""""""""""""""""""
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_collect_identifiers_from_tags_files = 1

""""""""""""""""""""""""""""""
" Vundle:ack
""""""""""""""""""""""""""""""
let g:ackhighlight=1
"let g:ack_autofold_results=1

""""""""""""""""""""""""""""""
" Vundle:ag
""""""""""""""""""""""""""""""
let g:ag_highlight=1
nnoremap <silent><F3> :Ag!<CR>

""""""""""""""""""""""""""""""
" Vundle:cscope
""""""""""""""""""""""""""""""
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
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>:copen<cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>:copen<cr>
nmap <leader>so :copen<cr>

""""""""""""""""""""""""""""""
" Vundle:syntastic
""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 0
let g:syntastic_cpp_check_header = 0
let g:syntastic_c_config_file = '.systastic_c_config'
let g:syntastic_cpp_config_file = '.systastic_cpp_config'

""""""""""""""""""""""""""""""
" Vundle:nerdcommenter
""""""""""""""""""""""""""""""
"Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
"let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

""""""""""""""""""""""""""""""
" Vundle:a.vim
""""""""""""""""""""""""""""""
" jump to header file
nmap <F4> :AT<cr>

""""""""""""""""""""""""""""""
" => logcat
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.logcat set filetype=logcat
au BufRead,BufNewFile *.txt set filetype=logcat

" 256-color putty
if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

nnoremap K :vimgrep "<C-R><C-W>" 

hi CursorLine ctermbg=DarkGray
