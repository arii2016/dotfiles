#!/bin/sh

cd $HOME
ln -s .dotfiles/.zshrc
ln -s .dotfiles/.gitconfig
ln -s .dotfiles/.vimrc
ln -s .dotfiles/.git-completion.bash
ln -s .dotfiles/.git-completion.zsh
ln -s .dotfiles/.git-prompt.sh
ln -s .dotfiles/.tmux.conf

mkdir .vim
cd .vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

if [ ! -e $HOME/.ssh ]; then
    mkdir $HOME/.ssh
fi
cd $HOME/.ssh
ln -s $HOME/.dotfiles/.ssh/config


if [ ! -e $HOME/.claude ]; then
    mkdir $HOME/.claude
fi
cd $HOME/.claude
ln -s $HOME/.dotfiles/.claude/CLAUDE.md
ln -s $HOME/.dotfiles/.claude/settings.json
ln -s $HOME/.dotfiles/.claude/statusline.sh
cd $HOME
