#!/bin/sh
if [ -e ~/.vimrc ]; then
mv -f ~/.vimrc ~/.vimrc_old
fi
 
ln -s `pwd`/vimrc ~/.vimrc

if [ -e ~/.bash_aliases ]; then
mv -f ~/.bash_aliases ~/.bash_aliases_old
fi
 
ln -s `pwd`/bash_aliases ~/.bash_aliases

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
