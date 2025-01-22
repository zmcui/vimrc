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
" => Plugs
"
" Description:
" This is the personal .vimrc file of zongmin.cui
"
""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible 	" Be iMproved
set history=1000      	" Lines of history VIM has to remember
set showcmd 		" Show incomplete cmds down the bottom
set showmode 		" Show current mode down the bottom
set backspace=2 	" make backspace work like most other programs
set nomodeline

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","

" keymaps Fast saving
nmap <leader>w :w!<cr>
"nmap <leader>q :bd<cr>
nmap <leader>q :bp<cr>:bd #<cr>

" Auto-reload your vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" look for tags up and up
set tags=./tags,tags;$HOME

" using clipboard as the default register
set clipboard=unnamedplus
" set clipboard=exclude:.* " never connect to the X server

" search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" keymaps nnoremap * *``
nmap <leader>* :vimgrep /<C-R><C-W>/j %<CR>:copen<CR>

" Copy then paste multiple times in Vim
xnoremap p pgvy

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
" Ignore case when completing file names and directories
set wildignorecase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kick vim to recognize 256-colors modern terminals
if $COLORTERM == "gnome-terminal" || $TERM == "xterm-256color" || $TERM == "screen-256color"
  set t_Co=256
endif

if has("gui_running")
  colorscheme solarized
else
  colorscheme desert
endif

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
set expandtab
" Be smart when using tabs
set smarttab
" number of space characters inserted for indentation
set shiftwidth=4
" 1 tab == 4 spaces
set tabstop=4
"Auto indent
set ai
"Smart indent
set si
"Wrap lines(default on)
set wrap
"<F2> as switch between paste and nopaste modes
set pastetoggle=<F2>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabpage, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open new tab page in quickfix window results
"set switchbuf+=usetab,newtab
set hidden

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" keymaps for managing tabs
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>

" keymaps Opens a new tab with the current buffer's path
map <leader>te :edit <c-r>=expand("%:p:h")<cr>/

" vim-powered terminal in new tab
map <Leader>tt :tab term ++close<cr>
tmap <Leader>tt <c-w>:tab term ++close<cr>

" Don't move cursor to start of line after various commands.
set nostartofline

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

" " Toggle to open or close the quickfix window
" command -bang -nargs=? QFix call QFixToggle(<bang>0)
" function! QFixToggle(forced)
"   if exists("g:qfix_win") && a:forced == 0
"     cclose
"     unlet g:qfix_win
"   else
"     copen 10
"     let g:qfix_win = bufnr("$")
"   endif
" endfunction
" nnoremap <silent> <F7> :QFix<CR>

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
" Plug: 'sheerun/vim-polyglot'
""""""""""""""""""""""""""""""
" polyglot_disabled should define before load plugin
" let g:polyglot_disabled = ['autoindent']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" interface
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/tagbar'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" IntelliSense
Plug 'valloric/youcompleteme'
Plug 'ervandew/supertab'
Plug 'vim-scripts/a.vim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
" Plug 'townk/vim-autoclose'
Plug 'Raimondi/delimitMate'
Plug 'habamax/vim-skipit'

" Syntax and Indent
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

" Format
Plug 'chiel92/vim-autoformat'
Plug 'rhysd/vim-clang-format'
Plug 'junegunn/vim-easy-align'

" Search
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'wsdjeg/vim-fetch'
" Plug 'ludovicchabant/vim-gutentags'

" doxygen
Plug 'vim-scripts/doxygentoolkit.vim'

" Initialize plugin system
call plug#end()

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

let g:html_use_xhtml = 1
function! MyToHtml(line1, line2)
  " make sure to generate in the correct format
  let old_css = 1
  if exists('g:html_use_css')
    let old_css = g:html_use_css
  endif
  let g:html_use_css = 0

  " generate and delete unneeded lines
  exec a:line1.','.a:line2.'TOhtml'
  %g/<body/normal k$dgg

  " convert body to a table
  %s/<body\s*\(bgcolor="[^"]*"\)\s*text=\("[^"]*"\)\s*>/<table \1 cellPadding=0><tr><td><font color=\2>/
  %s#</body>\(.\|\n\)*</html>#\='</font></td></tr></table>'#i

  " restore old setting
  let g:html_use_css = old_css
endfunction
command! -range=% MyToHtml :call MyToHtml(<line1>,<line2>)

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction
command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
