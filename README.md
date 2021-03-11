# Personal Vimrc Guide
Rev|Date|Author|Description
---|----------|----------|---------------
A  |2015.01.13|zongmincui|start up
B  |2019.07.31|zongmincui|vim8 update
C  |2019.08.03|zongmincui|replace vundle with plug
D  |2020.09.29|zongmincui|fzf

https://github.com/zmcui/vimrc

---
[TOC]

# Installation
## VIM 8.0
### PPA(Deprecated)
```bash?linenums=false
# Add the PPA
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
# To uninstall Vim 8.0 and downgrade it to the stock version in Ubuntu repository
sudo apt install ppa-purge && sudo ppa-purge ppa:jonathonf/vim
# Remove the PPA
sudo add-apt-repository --remove ppa:jonathonf/vim
```
ref
: [Vim 8.0 Released! How to install it in Ubuntu 16.04](http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04)

### SRC(Recommended)
默认安装的 Vim是支持python的，所以安装最新版本有点折腾
The actual location of the directory is controlled by --prefix
```bash?linenums=false
git clone https://github.com/vim/vim.git
cd vim

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local
# 安装目录在/usr/local/bin/vim

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

sudo make install
```

卸载
```bash?linenums=false
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make uninstall
```

Set vim as your default editor with update-alternatives.
```bash?linenums=false
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
```


refs:
[Building Vim from source](https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source)
[Vim 8 支持 Python 3 的一些坑](https://www.jishuwen.com/d/2KE0)
[Uninstalling Vim compiled from source](https://superuser.com/questions/623040/uninstalling-vim-compiled-from-source)

# basic Usage
## format
```vim
" fix the indentation
=
" fix the whole buffer
gg=G
```

## Replace
```vim
" replace the first match on the current line
:substitute/search/replace/
:s/search/replace/
" replace all of the matches on the current line
:s/search/replace/g
" replace all of the matches in entire file
" :% is the same as a range of 1,$
:g/search/s//replace/g
:%s/search/replace/g
```
ref
: [Vim 101: Search and Replace](http://usevim.com/2012/03/30/search-and-replace/)

## search
use vimgrep to pipe search result of current buffer to Quickfix window, like
```vim
:vimgrep "for.*bar" %
:copen
```
ref
: [pipe search result to other tab/window/buffer in VIM](https://stackoverflow.com/questions/13306664/pipe-search-result-to-other-tab-window-buffer-in-vim)

## hex edit 
```bash?linenums=false
# try openning in binary mode (no EOL)
vi -b xxx.bin
```
then `:%!xxd` -> `:%!xxd -r`

# Vim Customization
## Basic Config
### Indention
> indention cfg cooperate with vim-autoformat plugin
```vim?linenums=false
" Use spaces instead of tabs
set expandtab
" number of space characters inserted for indentation
set shiftwidth=4
" 1 tab == 4 spaces
set tabstop=4
```

### Quickfix
- fitting window height
```vim
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
```
ref
: [Automatically fitting a quickfix window height](http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height) 

### tab pages
- Navigation
```vim
"go to next tab
gt
"go to previous tab
gT
"go to tab in position i
{i}gt
```
- useful mappings
```vim
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
```
ref
: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim 
http://vim.wikia.com/wiki/VimTip630
[Using tab pages](http://vim.wikia.com/wiki/Using_tab_pages)

- cursor
```vim
" Don't move cursor to start of line after various commands.
set nostartofline
```
refs
: [Keep Window & Cursor Position When Switching Buffers](https://www.reddit.com/r/vim/comments/7c3bfk/keep_window_cursor_position_when_switching_buffers/)
[Don't move cursor to start of line after commands](https://github.com/bobwhitelock/dotfiles/commit/0bf674ccdadc89201a996a669b5ce3a9fb2fcf41)

### buffers
With :set hidden, opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
```vim
set hidden
```
refs
: [Vim Tab Madness. Buffers vs Tabs](http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)
[Vim 101: Set Hidden](https://medium.com/usevim/vim-101-set-hidden-f78800142855)

### 256-color putty
```vim
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
```
refs
: [putty vim color scheme](http://vim.wikia.com/wiki/Using_vim_color_schemes_with_Putty)

### Pasting code with syntax coloring in emails

```vim?linenums
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
```
refs
: [wiki](http://vim.wikia.com/wiki/Pasting_code_with_syntax_coloring_in_emails)

### Soure Code Tagging System
#### Ctags
```bash?linenums=false
# generate tags under current dir
ctags -R *
```
`crtl ]`: jump to definition of the function call which the cursor point to
`ctrl t`: go bach to where you came from

refs
: [VIM WITH CTAGS](https://linux.byexamples.com/archives/177/vim-with-ctags/)

#### cscope
1. install
Cscope is a very powerful interface allowing you to easily navigate C-like code files.
```bash?linenums=false
sudo apt install cscope
```
`s`   symbol: find all references to the token under cursor
`g`   global: find global definition(s) of the token under cursor
`c`   calls:  find all calls to the function name under cursor
`t`   text:   find all instances of the text under cursor
`e`   egrep:  egrep search for the word under cursor
`f`   file:   open the filename under cursor
`i`   includes: find files that include the filename under cursor
`d`   called: find functions that function under cursor calls
refs
: [linux kernel indexing](https://stackoverflow.com/questions/33676829/vim-configuration-for-linux-kernel-development)

2. config
- bindings
```vim
" cscope bindings
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>
```

- database
generate cscope.file
```bash?linenums=false
LNX=/home/zongmincui/work/asr_7p1_evb/kernel/linux
cd /
find $LNX                                                                \
    -path "$LNX/arch/*" ! -path "$LNX/arch/arm64*" -prune -o              \
    -path "$LNX/Documentation*" -prune -o                                 \
    -path "$LNX/scripts*" -prune -o                                       \
    -path "$LNX/drivers/media/platform/aquila-isp*" -prune -o             \
    -name "*.[chxsS]" -print > "$LNX/cscope.files"
```
generate cscope database
```bash?linenums=false
cscope -b -q -k
```
[Using Cscope on large projects](http://cscope.sourceforge.net/large_projects.html)

3. FAQ:
- how to create cscope.out file
```bash?linenums=false
cscope -Rbq
```
- open result quickfix window with :copen everytime
```vim
:copen
```

#### Gtags
```bash?linenums=false
# generate the GTAGS, GRTAGS, and GPATH files
gtags
```
refs
: [GNU Global](https://www.gnu.org/software/global/)
[GNU GLOBAL, THE PROGRAMMER’S FRIEND](https://linux.byexamples.com/archives/538/gnu-global-the-programmers-friend)

### Startup Time Cost
启动时把计时信息写入文件，用于分析载入 .vimrc、插件和打开首个文件的过程中时哪一步最耗时
```bash?linenums=false
vim --startuptime vim.log -c q

# times in msec
#  clock   self+sourced   self:  sourced script
#  clock   elapsed:              other lines
# 
# 000.006  000.006: --- VIM STARTING ---
# 000.101  000.095: Allocated generic buffers
# 000.182  000.081: locale set
# 000.200  000.018: GUI prepared
# 000.202  000.002: clipboard setup
# 000.206  000.004: window checked
# 000.835  000.629: inits 1
# 000.865  000.030: parsing arguments
# ...
# 038.610  000.020: inits 3
# 039.208  000.598: reading viminfo
# 2082.814  2043.606: setup clipboard
# 2082.862  000.048: setting raw mode
# ...
```

> Do not try connecting to the X server to get the current window title and copy/paste using the X clipboard.  This avoids a long startup time when running Vim in a terminal emulator and the connection to the X server is slow.
refs
: [vim takes a very long time to start up](https://stackoverflow.com/questions/14635295/vim-takes-a-very-long-time-to-start-up)

## Plugins
[VimAwesome](https://vimawesome.com/)
### Plugin Manager
#### VundleVim/Vundle.vim

#### junegunn/vim-plug
异步插件管理器 A minimalist Vim plugin manager.

### Interface
#### altercation/vim-colors-solarized
#### vim-airline/vim-airline
#### vim-airline/vim-airline-themes
#### scrooloose/nerdtree
#### majutsushi/tagbar
#### vim-scripts/a.vim
#### tpope/vim-fugitive
Diff between current file and the index
```vim
:Gdiff :0
```
Diff between current file and some other [revision]
```vim
:Gdiff [revision]
```
Diff between current file and current file 3 commits ago:
```vim
:Gdiff ~3
```
#### vim-scripts/doxygentoolkit.vim
#### Yggdroot/indentLine

### IntelliSense 
#### Valloric/YouCompleteMe
1. User Guide
- C-family Semantic Completion
There are 2 methods which can be used to provide compile flags to clang:
Option 1: Use a compilation database
> If no .ycm_extra_conf.py is found, YouCompleteMe automatically tries to load a compilation database if there is one.

Option 2: Provide the flags manually
> For a more elaborate example, see ycmd's own[ .ycm_extra_conf.py](https://raw.githubusercontent.com/Valloric/ycmd/66030cd94299114ae316796f3cad181cac8a007c/.ycm_extra_conf.py). You should be able to use it as a starting point

2. config
- `g:ycm_confirm_extra_conf`
 disable prompt if '.ycm_extra_conf.py' is safe to be loaded everytime
 
- g:ycm_use_clangd
```bash?linenums=false
# install YCM with both libclang and clangd enabled
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
./install.py --clangd-completer
```
当我用编译命令使能了libclang和clangd之后，并不知道当前ycm用了哪个，所以一直debug 下面的错误
其实是==ycm_extra_conf.py: Currently clangd does not support ycm_extra_conf.py therefore you must have a compilation database, whereas libclang can work with both.==
```
I[16:14:11.825] <-- initialize("1")
I[16:14:11.825] --> reply("1")
I[16:14:11.826] <-- initialized
E[16:14:11.826] Error -32601: method not found
I[16:14:11.826] <-- workspace/didChangeConfiguration
I[16:14:11.826] <-- textDocument/didOpen
I[16:14:11.826] Failed to find compilation database for /home/zongmincui/work/baremetal-test/ctest/modules/mars10isp/mars10_drv.c
I[16:14:11.826] Updating file /home/zongmincui/work/baremetal-test/ctest/modules/mars10isp/mars10_drv.c with command [/home/zongmincui/work/baremetal-test/ctest/modules/mars10isp] clang /home/zongmincui/work/baremetal-test/ctest/modules/mars10isp/mars10_drv.c -resource-dir=/home/zongmincui/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clang/lib/clang/7.0.0
I[16:14:11.837] Dropped diagnostic outside main file: : too many errors emitted, stopping now
```

- `g:ycm_semantic_triggers`
默认输入情况下，是符号补全，YCM 的语义补全一直使用被动触发（输入 ->或 . 或 ::，或者按 CTRL+SPACE/Z）
```vim
" trigger semantic complete when type
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }
```
这里我们追加了一个正则表达式，代表相关语言的源文件中，用户只需要输入符号的两个字母，即可自动弹出语义补全：

3. FAQ:
- prompt header file not found when open source file
删除.ycm_extra_conf.py配置里的`'-I’, '.'`

- YCM doesn't complete any identifier that exists in a header file
That is the right behaviour, you're not seeing anything strange. The identifier completer will propose candidates from the currently open buffers, so if you don't have the headers file as open buffers you will not get identifiers from that file as candidates. 

refs
: [#1624](https://github.com/Valloric/YouCompleteMe/issues/1624)
[how to enable semantic complete when typing](https://zhuanlan.zhihu.com/p/33046090)

- Navigating the Linux Kernel source tree with YouCompleteMe
the [bear](https://github.com/rizsotto/Bear) utility takes the approach of intercepting the build calls, gather the relevant info and generate a complete compilation database. 

refs
: [Navigating the Linux Kernel source tree with YouCompleteMe](https://www.scalyr.com/blog/searching-1tb-sec-systems-engineering-before-algorithms/)
[YouCompleteMe 中容易忽略的配置](https://zhuanlan.zhihu.com/p/33046090)

- Failed to connect to go.googlesource.com
```bash?linenums=false
# 配置git全局代理
git config --global http.proxy "localhost:1080"
# 删除git全局代理
git config --global --unset http.proxy
```
refs
: [Git设置代理拉取](https://my.oschina.net/dingdayu/blog/1509885)

- fails to clone git://github.com/mitsuhiko/flask-sphinx-themes.git
```bash?linenums=false
# You can force all git: to use https with some .gitconfig magic:
git config --global url."https://".insteadOf git://
```
refs
: [Update the ycmd submodule to the latest commit](https://github.com/ycm-core/YouCompleteMe/pull/3646)

- clangd memory consumption problem and UI freeze
They don't believe it is related to background indexing after all. I also learnt that you need to pass --background-index=false to actually disable it. That's why it didn't make a difference.
```diff?linenums=false
diff --git i/ycmd/completers/cpp/clangd_completer.py w/ycmd/completers/cpp/clangd_completer.py
index cb42c95e..15a65810 100644
--- i/ycmd/completers/cpp/clangd_completer.py
+++ w/ycmd/completers/cpp/clangd_completer.py
@@ -149,6 +149,8 @@ def GetClangdCommand( user_options ):
     put_header_insertion_decorators = ( put_header_insertion_decorators or
                         arg.startswith( '-header-insertion-decorators' ) )
     put_log = put_log or arg.startswith( '-log' )
+  # czm
+  CLANGD_COMMAND.append( '--background-index=false' )
   if not put_header_insertion_decorators:
     CLANGD_COMMAND.append( '-header-insertion-decorators=0' )
   if resource_dir and not put_resource_dir:
```
refs
: [lsp-mode + clangd memory consumption problem](https://www.reddit.com/r/emacs/comments/eme5zk/lspmode_clangd_memory_consumption_problem/)

#### rdnetto/ycm-generator

#### ervandew/supertab

#### sirver/ultisnips

#### honza/vim-snippets

#### scrooloose/nerdcommenter

#### Townk/vim-autoclose

#### habamax/vim-skipit
Skip text in INSERT mode.

If you have g:skipit_default_mappings set to 1 then while INSERT mode on press \<CTRL-L\> l to skip everything until parentheses, bars or quotes and place cursor right after them.

### Syntax
#### sheerun/vim-polyglot
A collection of language packs for Vim.

#### vim-scripts/Logcat-syntax-highlighter

#### plasticboy/vim-markdown

#### vhda/verilog_systemverilog.vim

#### octol/vim-cpp-enhanced-highlight

### Syntastic
#### scrooloose/syntastic
##### FAQ:
- Including header files recursively for syntastic
[how to](http://stackoverflow.com/questions/16622992/including-header-files-recursively-for-syntastic)

#### w0rp/ale

### Formatting
#### Chiel92/vim-autoformat
#### rhysd/vim-clang-format
```vim
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
```
PointerAlignment: Right is unfortunately not implemented yet.(see refs)

refs
: [CLANG-FORMAT STYLE OPTIONS](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
[clang-format: Align asterisk (\*) of pointer declaration with variable name Ask](https://stackoverflow.com/questions/38392889/clang-format-align-asterisk-of-pointer-declaration-with-variable-name)

##### FAQ
- Can clang-format align a block of #defines for me?
目前clang-format还支持不了宏定义的对齐, 从llvm的讨论看，比较有争议

refs
: [stachoverflow: Can clang-format align a block of #defines for me?](https://stackoverflow.com/questions/38620019/can-clang-format-align-a-block-of-defines-for-me)
[clang-format: Add new style option AlignConsecutiveMacros](https://reviews.llvm.org/D28462?id=93341)

#### godlygeek/tabular

### Searching and Find
#### ctrlpvim/ctrlp.vim
[github](https://github.com/ctrlpvim/ctrlp.vim)
Full path fuzzy file, buffer, mru, tag, ... finder for Vim.

#### junegunn/fzf.vim
[github](https://github.com/junegunn/fzf.vim)
fuzzy finder can be used with any list; files, command history, processes, hostnames, bookmarks, git commits, etc.

#### mileszs/ack.vim
1. configuration
```vim
""""""""""""""""""""""""""""""
" Vundle:ack
""""""""""""""""""""""""""""""
let g:ackhighlight=1
"let g:ack_autofold_results=1
```
#### rking/ag.vim
1. configuration
```vim
""""""""""""""""""""""""""""""
" Vundle:ag
""""""""""""""""""""""""""""""
let g:ag_highlight=1
nnoremap <silent><F3> :Ag!<CR>
```

#### wsdjeg/FlyGrep.vim
1. configuration
```vim
""""""""""""""""""""""""""""""
" Vundle: FlyGrep.vim
""""""""""""""""""""""""""""""
nnoremap <C-F> :FlyGrep<CR>
```

#### easymotion/vim-easymotion
[github](https://github.com/easymotion/vim-easymotion)
1. usage
跳转到当前光标前后的位置(w/b)
```vim
<leader><leader>w
<leader><leader>b
```
搜索跳转(s)
```vim
<leader><leader>s
```
行级跳转(jk)
```vim
<leader><leader>j
<leader><leader>k
```
行内跳转(hl)
```vim
<leader><leader>h
<leader><leader>l
```