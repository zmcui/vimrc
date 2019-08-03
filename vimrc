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
" => Plugins
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

" search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"nnoremap * *``
nmap <leader>* :vimgrep /<C-R><C-W>/j %<CR>:copen<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" original repos on github
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/doxygentoolkit.vim'

" Plugin 'Shougo/echodoc.vim'
Plugin 'valloric/youcompleteme'
" Plugin 'rdnetto/ycm-generator'
" Plugin 'rip-rip/clang_complete'
Plugin 'ervandew/supertab'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdcommenter'
Plugin 'townk/vim-autoclose'

Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Plugin 'w0rp/ale'

Plugin 'chiel92/vim-autoformat'
Plugin 'rhysd/vim-clang-format'
Plugin 'godlygeek/tabular'

Plugin 'wsdjeg/FlyGrep.vim'
Plugin 'easymotion/vim-easymotion'


call vundle#end()            " required
filetype plugin indent on    " required

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
"paste from another application
set pastetoggle=<F2>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open new tab page in quickfix window results
"set switchbuf+=usetab,newtab
set hidden

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
map <leader>te :edit <c-r>=expand("%:p:h")<cr>/

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
" buffer mode in default
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
" Use a custom file listing command
let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_window = 'top'

""""""""""""""""""""""""""""""
" Vundle:YouCompleteMe
""""""""""""""""""""""""""""""
set completeopt=menu,menuone "no completion in the preview window
let g:ycm_add_preview_to_completeopt = 0 "no add preview
let g:ycm_use_clangd = 1 	"libclang/clangd
" set splitbelow
let g:ycm_global_ycm_extra_conf='/home/zongmincui/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" trigger semantic complete when type
" let g:ycm_semantic_triggers =  {
"                         \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"                         \ 'cs,lua,javascript': ['re!\w{2}'],
"                         \ }
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ }

""""""""""""""""""""""""""""""
" Vundle:ultisnips
""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""
" Vundle: FlyGrep.vim
""""""""""""""""""""""""""""""
nnoremap <C-F> :FlyGrep<CR>

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
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" "let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_c_check_header = 0
" let g:syntastic_cpp_check_header = 0
" let g:syntastic_c_config_file = '.systastic_c_config'
" let g:syntastic_cpp_config_file = '.systastic_cpp_config'
"
""""""""""""""""""""""""""""""
" Vundle:ale
""""""""""""""""""""""""""""""
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta
""""""""""""""""""""""""""""""
" Vundle:nerdcommenter
""""""""""""""""""""""""""""""
"Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'k': { 'left': '//','right': '' } }
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
au BufRead,BufNewFile *.dmsg set filetype=dmsg

""""""""""""""""""""""""""""""
" Vundle: rhysd/vim-clang-format
""""""""""""""""""""""""""""""
let g:clang_format#style_options = {
    \ 'ColumnLimit' : "0",
    \ 'IndentWidth' : 8,
    \ 'UseTab' : 'Always',
    \ 'BreakBeforeBraces' : 'Linux',
    \ 'AllowShortIfStatementsOnASingleLine' : 'false',
    \ 'AllowShortLoopsOnASingleLine' : 'false',
    \ 'AllowShortFunctionsOnASingleLine' : 'false',
    \ 'IndentCaseLabels' : 'false',
    \ 'AlignEscapedNewlinesLeft' : 'false',
    \ 'AlignTrailingComments' : 'true',
    \ 'SpacesBeforeTrailingComments' : 3,
    \ 'AllowAllParametersOfDeclarationOnNextLine' : 'false',
    \ 'AlignAfterOpenBracket' : 'true',
    \ 'SpaceAfterCStyleCast' : 'false',
    \ 'MaxEmptyLinesToKeep' : 2,
    \ 'BreakBeforeBinaryOperators' : 'NonAssignment',
    \ 'SortIncludes' : 'false',
    \ 'ContinuationIndentWidth' : 8,
    \ 'AlignConsecutiveDeclarations' : 'false',
    \ 'AlignConsecutiveAssignments' : 'false',
    \ 'DerivePointerAlignment' : 'false',
    \ 'PointerAlignment' : 'Right',
    \}

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

hi CursorLine ctermbg=DarkGray

"
" Causes all comment folds to be opened and closed using z[ and z]
" respectively.
"
" Causes all block folds to be opened and closed using z{ and z} respectively.
"

"function FoldOnlyMatching(re, op)
"	mark Z
"	normal gg
"	let s:lastline = -1
"	while s:lastline != line('.')
"		if match(getline(line('.')), a:re) != -1
"			exec 'normal ' . a:op
"		endif
"		let s:lastline = line('.')
"		normal zj
"	endwhile
"	normal 'Z
"	unlet s:lastline
"endfunction

nnoremap <silent> <leader>z[ :call FoldOnlyMatching('/[*][*]', 'zo')<CR>
nnoremap <silent> <leader>z] :call FoldOnlyMatching('/[*][*]', 'zc')<CR>
nnoremap <silent> <leader>z{ :call FoldOnlyMatching('[ \t]*{', 'zo')<CR>
nnoremap <silent> <leader>z} :call FoldOnlyMatching('[ \t]*{', 'zc')<CR>

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
