""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" zongmin.cui
"
" Repository:
" https://github.com/zmcui/vimrc.git
"
" Version:
" 2015-01-13 12:17:12
""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible		"Be iMproved
set history=1000		"Lines of history VIM has to remember
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle 
" required!
Bundle 'gmarik/vundle'
" My Bundles here
" original repos on github
Bundle 'bling/vim-airline'

filetype plugin indent on     " required!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

""""""""""""""""""""""""""""""
" => Timestamp 
""""""""""""""""""""""""""""""
"insert timestamp using "xtime" in insert mode
"RFC822 format:%a, %d %b %Y %H:%M:%S %z   Wed, 29 Aug 2007 02:37:15 -0400
iab xtime <c-r>=strftime("%d-%m-%y %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%a, %d %b %Y %H:%M:%S %z")<cr>
