# Personal Vimrc Guide
`by iryan.cui@gmail.com`

---
[TOC]

## Installation
### VIM 8.0
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

## basic Usage
### format
```vim
" fix the indentation
=
" fix the whole buffer
gg=G
```

### Replace
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

## vimrc
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

## Vundles
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

#### FAQ:
- prompt header file not found when open source file
删除.ycm_extra_conf.py配置里的`'-I’, '.'`

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
