export PATH="$HOME/.local/bin:$PATH"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -FG'
alias la='ls -a'
alias ll='ls -la'
alias vi='vim'

# 上下キーでいい感じに入力補完してくれる
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# ついでに履歴の件数も上げておく
export SAVEHIST=100000

# 色を使用出来るようにする
autoload -Uz colors
colors

# 補完機能を有効にする
autoload -Uz compinit
compinit

# プロンプト
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1

setopt PROMPT_SUBST
PS1='%{%F{white}%}[%{%F{cyan}%}%n%{%F{white}%}@%m %{%F{green}%}%1~%{%F{white}%}]%{%F{red}%}$(__git_ps1)%{%f%}$ '

