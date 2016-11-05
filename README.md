# Personal Vimrc Guide
---
[TOC]

## basic Usage
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

## Vundles
Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Buddle 'vim-scripts/taglist.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'lrvick/Conque-Shell'

### taglist
#### FAQ:
- Error when switch to tab with taglist opened

![enter description here][1]

[How to Fix](https://github.com/rgo/taglist.vim/commit/2c664eee00e702523d28ae0813f3f343f56098ee)

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

## [Using tab pages](http://vim.wikia.com/wiki/Using_tab_pages)
### Navigation
```vim
"go to next tab
gt
"go to previous tab
gT
"go to tab in position i
{i}gt
```
useful mappings for managing tabs
```vim
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
```



ref
: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim 
http://vim.wikia.com/wiki/VimTip630


  [1]: ./images/Screenshot%20from%202016-06-12%2016:55:16.png "Screenshot from 2016-06-12 16:55:16.png"