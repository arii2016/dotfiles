#!/bin/sh

cd $HOME
ln -s .dotfiles/.tcshrc
ln -s .dotfiles/.gitconfig
ln -s .dotfiles/.vimrc
ln -s .dotfiles/.tmux.conf

mkdir .vim
cd .vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

