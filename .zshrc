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

# enable vcs (git) info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats $'%{\e[38;5;193m%}[%b] %r/%S %m %{\e[0m%}'
precmd() {
    vcs_info
}
setopt prompt_subst

# prompt
[ -n "${SSH_CONNECTION}" ] && prefix="(ssh) "

export PS1=$'${prefix:-""}%{\e[38;5;39m%}%n%{\e[0m%}@%{\e[38;5;173m%}%M%{\e[0m%}:%{\e[38;5;155m%}%~%{\e[0m%} %# '
export RPS1=$'${vcs_info_msg_0_}'

# aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias lla='ls -lha'
alias md=mkdir
alias rd='rm -r'
for c in cp mv mkdir chmod chown; do
    alias $c="$c -v"
done
alias rm='rm -iv'
#alias recdwm='cd ~/.dwm; makepkg -efi --skipinteg; killall dwm'
alias ff='find -type f -iname'
alias fd='find -type d -iname'
alias c='clear'
alias pacup='sudo pacman -Syu'
alias pacins='sudo pacman -S'
alias pacrem='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacclean='sudo pacman -Scc'

export EDITOR=vim
