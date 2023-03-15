#!/bin/sh
if [ -e ~/.vimrc ]; then
    mv -f ~/.vimrc ~/.vimrc_bp
fi
ln -s `pwd`/vimrc ~/.vimrc

if [ -e ~/.bash_aliases ]; then
    mv -f ~/.bash_aliases ~/.bash_aliases_bp
fi
ln -s `pwd`/bash_aliases ~/.bash_aliases

# install extended UltiSnips
if [ -e ~/.vim/UltiSnips ]; then
    mv -f ~/.vim/UltiSnips ~/.vim/UltiSnips_bp
fi
ln -s `pwd`/UltiSnips ~/.vim/UltiSnips

# install vundle for vim
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
