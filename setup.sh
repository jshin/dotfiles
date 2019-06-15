#!/bin/bash

set -eu

echo "Start setup of dotfiles..."

BASE_DIR=$(cd $(dirname $0); pwd)

for file in .??*; do
    if [ $file != ".git" -a $file != ".gitignore" ]; then
        ln -sfv $BASE_DIR/$file $HOME
    fi
done

git config --global user.name 'jshin'
git config --global user.email '9659726+jshin@users.noreply.github.com'

# for neovim
ln -sfv $BASE_DIR/.vim/after/ftplugin $BASE_DIR/.config/nvim

# dein.vim install
if [ ! -d "${BASE_DIR}/.vim/bundles" ]; then
    echo "Start installing dein.vim..."
    mkdir $BASE_DIR/.vim/bundles
    cd $BASE_DIR/.vim/bundles
    curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh .
    cd -
fi

echo ""
echo "Finish setup of dotfiles"
