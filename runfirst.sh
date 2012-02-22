#!/bin/bash -ev
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u ~/.vim/bundles.vim +BundleInstall +q +q +q
if [ -e ~/.vimrc ]
then
    echo "moving ~/.vimrc -> ~/.vimrc.autobak"
    mv ~/.vimrc ~/.vimrc.autobak
fi
ln -sf ~/.vim/vimrc ~/.vimrc
