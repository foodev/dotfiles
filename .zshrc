# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

. /usr/share/doc/pkgfile/command-not-found.zsh

setopt hist_ignore_all_dups
setopt hist_ignore_space

# keybinds
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# 
export EDITOR=vim

# promt
export PS1=$'%{\e[0;37m%}[%{\e[0;37m%}%D %T%{\e[0;37m%}]%{\e[0m%} %{\e[0;34m%}%n%{\e[0m%}@%{\e[1;33m%}%M%{\e[0m%} %{\e[1;31m%}%~%{\e[0m%} %# '

# aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias lla='ls -lha'
alias md=mkdir
alias rd='rm -r'
for c in cp mv mkdir rm chmod chown; do
    alias $c="$c -v"
done
alias recdwm='cd ~/.dwm; makepkg -efi --skipinteg; killall dwm'
alias pacman='sudo pacman'
alias ff='find -type f -iname'
alias fd='find -type d -iname'
alias c='clear'
