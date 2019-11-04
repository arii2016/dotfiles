#!/bin/sh

cd $HOME
ln -s .dotfiles/.tcshrc
ln -s .dotfiles/.gitconfig
ln -s .dotfiles/.vimrc
ln -s .dotfiles/.git-completion.bash
ln -s .dotfiles/.git-completion.tcsh

mkdir .vim
cd .vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

if [ ! -e .ssh ]; then
    mkdir .ssh
fi
cd $HOME/.ssh
ln -s $HOME/.dotfiles/.ssh/config
cd $HOME
