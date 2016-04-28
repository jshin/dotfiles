#!/bin/bash

DOT_FILES=(.zshrc .bash_profile .vimrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
