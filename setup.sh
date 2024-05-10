#!/usr/bin/env bash

function linkPath() {
    if [[ ! -e $2 ]]; then
        echo "$2 does not exist"
        return -1
    fi

    if [ -L $1 ]; then # link
        echo "link: ~/.vimrc -> $(realpath $1)"
        unlink $1
    elif [ -e $1 ] ; then # file
        echo "file: $(realpath `$1`)"
        mv -rf $1 $1+"_bp"
    fi
    ln -s $2 $1
    echo "$1 -> $2 done!"
}

linkPath ~/.vimrc `pwd`/vimrc
linkPath ~/.vim/ftdetect `pwd`/ftdetect
linkPath ~/.vim/after `pwd`/after
# install extended UltiSnips
linkPath ~/.vim/UltiSnips `pwd`/UltiSnips
linkPath ~/.bash_aliases `pwd`/bash_aliases

# install vundle for vim
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle