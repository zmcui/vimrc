# Personal Vimrc Guide
https://github.com/zmcui/vimrc

---
[TOC]

# Installation
## VIM 8.0
```bash
# run command to add the PPA
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
# To uninstall Vim 8.0 and downgrade it to the stock version in Ubuntu repository
sudo apt install ppa-purge && sudo ppa-purge ppa:jonathonf/vim
```
ref
: [Vim 8.0 Released! How to install it in Ubuntu 16.04](http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04)

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

# Vim Customization
## basic config
### quickfix
- fitting window height
```vim
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
```
ref
: [Automatically fitting a quickfix window height](http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height) 

### tabs
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


## Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
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
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Chiel92/vim-autoformat'
Plugin 'rhysd/vim-clang-format'
Plugin 'easymotion/vim-easymotion'

### cscope
#### config
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
```bash
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
```bash
cscope -b -q -k
```

[Using Cscope on large projects](http://cscope.sourceforge.net/large_projects.html)


#### FAQ:
- how to install cscope before usage
```bash
sudo apt-get install cscope
```

- how to create cscope.out file
```bash
cscope -Rbq
```
- open result quickfix window with :copen everytime
```vim
:copen
```
### YouCompleteMe
#### config
- `g:ycm_confirm_extra_conf`
 disable prompt if '.ycm_extra_conf.py' is safe to be loaded everytime
 
- g:ycm_use_clangd
```bash
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


#### FAQ:
- prompt header file not found when open source file
删除.ycm_extra_conf.py配置里的`'-I’, '.'`

- YCM doesn't complete any identifier that exists in a header file
That is the right behaviour, you're not seeing anything strange. The identifier completer will propose candidates from the currently open buffers, so if you don't have the headers file as open buffers you will not get identifiers from that file as candidates. 

refs
: [#1624](https://github.com/Valloric/YouCompleteMe/issues/1624)
[how to enable semantic complete when typing](https://zhuanlan.zhihu.com/p/33046090)

### syntastic
#### FAQ:
- Including header files recursively for syntastic
[how to](http://stackoverflow.com/questions/16622992/including-header-files-recursively-for-syntastic)

### vim-fugitive
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

### vim-clang-format
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