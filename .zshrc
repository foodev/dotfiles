# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zshhist
setopt appendhistory autocd extendedglob
setopt hist_ignore_all_dups
setopt hist_ignore_space

# keybinds
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# completion
autoload -U compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# enable vcs (git) info
# http://sourceforge.net/p/zsh/code/ci/master/tree/Misc/vcs_info-examples
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# →  (%s)
zstyle ':vcs_info:git*' formats $' %{\e[38;5;250m%}on %{\e[38;5;193m%}%b %{\e[38;5;250m%}→ %{\e[38;5;193m%}/%S%{\e[0m%}'
precmd() {
    vcs_info
}
setopt prompt_subst

# prompt
[ -n "${SSH_CONNECTION}" ] && prefix="(ssh) "

if [ `whoami` = "root" ]; then
    export PS1=$'%{\e[38;5;250m%}${prefix:-""}%{\e[38;5;1m%}%n%{\e[38;5;250m%}@%{\e[38;5;173m%}%M%{\e[38;5;250m%}:%{\e[38;5;155m%}%~%{\e[0m%}${vcs_info_msg_0_} %{\e[38;5;1m%}λ%{\e[0m%} '
else
    export PS1=$'%{\e[38;5;250m%}${prefix:-""}%{\e[38;5;39m%}%n%{\e[38;5;250m%}@%{\e[38;5;173m%}%M%{\e[38;5;250m%}:%{\e[38;5;155m%}%~%{\e[0m%}${vcs_info_msg_0_} %{\e[38;5;250m%}λ%{\e[0m%} '
fi

# aliases
alias grep='grep --color=auto'
alias rm='rm -iv'
alias ls='ls --color=auto'
alias l='ls -lh'
alias la='ls -lha'
alias md='mkdir'
alias rd='rm -r'
for c in cp mv mkdir chmod chown; do
    alias $c="$c -v"
done
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias c='clear'
alias v='vim'
alias t='htop'
alias df='df -h'
alias du='du -h'
alias tree='tree -h'
alias pacup='pacaur -Syu'
alias pacins='pacaur -S'
alias pacrem='sudo pacaur -Rns'
alias pacinfo='sudo pacaur -Si'
alias pacsearch='pacaur -Ss'
alias pacclean='sudo pacaur -Scc'
alias diff='colordiff'
alias g='git'
alias s='ack --literal'
alias ntop='sudo jnettop -i enp0s25'

export EDITOR=vim
export TERM=xterm-256color

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/seebi/dircolors-solarized
eval `dircolors $HOME/.dircolors`
