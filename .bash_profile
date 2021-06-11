# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
if [[ "$OSTYPE" == "darwin"* ]]; then
        export BASH_SILENCE_DEPRECATION_WARNING=1
fi
