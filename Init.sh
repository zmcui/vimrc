#!/bin/sh
if [ -e ~/.vimrc ]; then
mv -f ~/.vimrc ~/.vimrc_old
fi
 
ln -s `pwd`/vimrc ~/.vimrc
