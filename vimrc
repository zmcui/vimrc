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
" set clipboard=exclude:.* " never connect to the X server

" search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"nnoremap * *``
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

" Useful mappings for managing tabs
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
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
let g:polyglot_disabled = ['autoindent']

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
Plug 'vim-scripts/doxygentoolkit.vim'
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
" Plug 'ludovicchabant/vim-gutentags'
" Initialize plugin system
call plug#end()

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
" plug: ctrlp
""""""""""""""""""""""""""""""
" buffer mode in default
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
" Use a custom file listing command
let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_window = 'top'

let g:ctrlp_mruf_default_order = 0

""""""""""""""""""""""""""""""
" Plug: fzf
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" Plug: indentLine
""""""""""""""""""""""""""""""
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 238
" let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1

""""""""""""""""""""""""""""""
" Vundle:YouCompleteMe
""""""""""""""""""""""""""""""
" libclang or clangd(recommanded)
let g:ycm_use_clangd = 1
" clangd memory consumption problem and UI freeze
let g:ycm_clangd_args = ['-log=verbose', '-pretty', '--background-index=false']
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" use C/C++ syntax highlighting in the popup for C-family languages
augroup MyYCMCustom
  autocmd!
  autocmd FileType c,cpp let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
augroup END

set completeopt=menu,menuone "no completion in the preview window
let g:ycm_add_preview_to_completeopt = 0 "no add preview
" set splitbelow
let g:ycm_global_ycm_extra_conf='/home/zongmincui/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_show_diagnostics_ui = 1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" trigger semantic complete when type
let g:ycm_semantic_triggers =  {
                         \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                         \ 'cs,lua,javascript': ['re!\w{2}'],
                         \ }
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:ycm_filetype_whitelist = { 
	\ "c":1,
	\ "cpp":1, 
	\ "objc":1,
	\ "sh":1,
	\ "zsh":1,
	\ "markdown":1,
	\ "vim":1,
	\ "CMakeLists.txt":1,
	\ "python":1,
	\ "Kconfig":1,
	\ "Makefile":1,
	\ }

let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'leaderf': 1,
      \ 'mail': 1
      \}
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
" Plug: vim-scripts/doxygentoolkit.vim
""""""""""""""""""""""""""""""
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_briefTag_post="-"
let g:DoxygenToolkit_paramTag_pre="@"
let g:DoxygenToolkit_paramTag_post=":"
let g:DoxygenToolkit_returnTag="Return: 0 on success, error code otherwise."

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

""""""""""""""""""""""""""""""
" Vundle:ale
""""""""""""""""""""""""""""""
" let g:ale_linters_explicit = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" let g:airline#extensions#ale#enabled = 1
"
" let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" let g:ale_c_cppcheck_options = ''
" let g:ale_cpp_cppcheck_options = ''
"
" let g:ale_sign_error = "\ue009\ue009"
" hi! clear SpellBad
" hi! clear SpellCap
" hi! clear SpellRare
" hi! SpellBad gui=undercurl guisp=red
" hi! SpellCap gui=undercurl guisp=blue
" hi! SpellRare gui=undercurl guisp=magenta
"
" let g:ale_linters = {
" \   'c++': ['cppcheck'],
" \   'c': ['cppcheck'],
" \   'python': ['pylint'],
" \}

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
" Plug: 'Raimondi/delimitMate'
""""""""""""""""""""""""""""""
let delimitMate_jump_expansion = 1

""""""""""""""""""""""""""""""
" Plug: 'habamax/vim-skipit'
""""""""""""""""""""""""""""""
let g:skipit_default_mappings = 1

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
" Vundle: rhysd/vim-autoformat
""""""""""""""""""""""""""""""
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']

""""""""""""""""""""""""""""""
" Vundle: rhysd/vim-clang-format
""""""""""""""""""""""""""""""
let g:clang_format#detect_style_file = 1
" Your filetype specific options
let g:clang_format#filetype_style_options = {
    \   'cpp' : {
    \          "BasedOnStyle" : "Google",
    \          "ColumnLimit" : "0",
    \          "IndentCaseLabels" : "true",
    \          "IndentWidth" : 4,
    \          "ContinuationIndentWidth" : 4,
    \          "BreakBeforeBraces" : "Linux",
    \          "AlignConsecutiveDeclarations" : "false",
    \          "AlignConsecutiveAssignments" : "false",
    \          "AlignConsecutiveMacros" : "true",
    \          "Standard" : "Cpp11",
    \          "TabWidth" : 8,
    \          "UseTab" : "Never",
    \          "DeriveLineEnding": "false",
    \          "UseCRLF"  :  "false"
    \           },
    \   'c' : {
    \          "ColumnLimit" : "0",
    \          "IndentWidth" : 8,
    \          "BreakBeforeBraces" : "Linux",
    \          "AllowShortIfStatementsOnASingleLine" : "false",
    \          "AllowShortLoopsOnASingleLine" : "false",
    \          "AllowShortFunctionsOnASingleLine" : "false",
    \          "IndentCaseLabels" : "false",
    \          "AlignEscapedNewlinesLeft" : "false",
    \          "AlignTrailingComments" : "true",
    \          "SpacesBeforeTrailingComments" : 3,
    \          "AllowAllParametersOfDeclarationOnNextLine" : "false",
    \          "AlignAfterOpenBracket" : "true",
    \          "SpaceAfterCStyleCast" : "false",
    \          "MaxEmptyLinesToKeep" : 2,
    \          "BreakBeforeBinaryOperators" : "NonAssignment",
    \          "SortIncludes" : "false",
    \          "ContinuationIndentWidth" : 8,
    \          "AlignConsecutiveDeclarations" : "false",
    \          "AlignConsecutiveAssignments" : "false",
    \          "AlignConsecutiveMacros" : "true",
    \          "DerivePointerAlignment" : "false",
    \          "PointerAlignment" : "Right",
    \          "Standard" : "Cpp11",
    \          "TabWidth" : 8,
    \          "UseTab" : "Always",
    \          "DeriveLineEnding": "false",
    \          "UseCRLF"  :  "false"
    \         },
    \ }

""""""""""""""""""""""""""""""
" Plug: 'junegunn/vim-easy-align'
""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""
" Plug: 'habamax/vim-skipit'
""""""""""""""""""""""""""""""
let g:skipit_default_mappings = 1

""""""""""""""""""""""""""""""
" Plug: 'airblade/vim-gitgutter'
""""""""""""""""""""""""""""""
" let g:gitgutter_diff_args='--cached'
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

""""""""""""""""""""""""""""""
" Vundle: vim-gutentags
" Vundle: gutentags_plus'
""""""""""""""""""""""""""""""
"" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
"" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'
"
"" 同时开启 ctags 和 gtags 支持：
"let g:gutentags_modules = []
"if executable('ctags')
"	let g:gutentags_modules += ['ctags']
"endif
"if executable('gtags-cscope') && executable('gtags')
"	let g:gutentags_modules += ['gtags_cscope']
"endif
"
"" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags
"
"" 配置 ctags 的参数
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
"" 如果使用 universal ctags 需要增加下面一行
"" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
"
"" 禁用 gutentags 自动加载 gtags 数据库的行为
"" let g:gutentags_auto_add_gtags_cscope = 0
"
"" 检测 ~/.cache/tags 不存在就新建
"if !isdirectory(s:vim_tags)
"   silent! call mkdir(s:vim_tags, 'p')
"endif


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
