# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

case $OSTYPE in
    darwin*)
        alias ls='ls -FG';;
    *)
        alias ls='ls -F --color=auto'
        alias setdsp="setenv DISPLAY \!*\:0.0"
esac
alias la='ls -a'
alias ll='ls -la'
alias vi='vim'

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1
# export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
export PS1='\[\033[37m\][\[\033[36m\]\u\[\033[37m\]@\h \[\033[32m\]\W\[\033[37m\]]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

export PATH=$PATH:/usr/bin:$HOME/.dotfiles/bin
if [[ "$OSTYPE" == "darwin"* ]]; then
    export IDF_PATH=$HOME/esp/esp-idf
    export PATH=$PATH:$HOME/esp/xtensa-esp32-elf/bin:$HOME/.nodebrew/current/bin
fi

# 上矢印キー
bind '"\e[A": history-search-backward'
# 下矢印キー
bind '"\e[B": history-search-forward'
