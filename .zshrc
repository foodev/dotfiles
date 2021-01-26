# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zshhist
setopt appendhistory autocd extendedglob
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Keybinds
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# Load custom auto completion files
#fpath=(~/.dotfiles/zsh-completion $fpath)

# Auto completion
autoload -U compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Enable git info
# http://sourceforge.net/p/zsh/code/ci/master/tree/Misc/vcs_info-examples
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats $' %{\e[38;5;250m%}→ %{\e[38;5;193m%}%b%{\e[0m%}'
precmd() {
    vcs_info
}
setopt prompt_subst

# Prompt
[ -n "${SSH_CONNECTION}" ] && prefix="(ssh) "

if [ `whoami` = "root" ]; then
    export PS1=$'%{\e[38;5;250m%}${prefix:-""}%{\e[38;5;1m%}%n%{\e[38;5;250m%}@%{\e[38;5;173m%}%m%{\e[38;5;250m%}:%{\e[38;5;155m%}%~%{\e[0m%}${vcs_info_msg_0_} %{\e[38;5;1m%}λ%{\e[0m%} '
else
    export PS1=$'%{\e[38;5;250m%}${prefix:-""}%{\e[38;5;39m%}%n%{\e[38;5;250m%}@%{\e[38;5;173m%}%m%{\e[38;5;250m%}:%{\e[38;5;155m%}%~%{\e[0m%}${vcs_info_msg_0_} %{\e[38;5;250m%}λ%{\e[0m%} '
fi

# Functions
function find_duplicates() {
    find $1 -type f -exec md5sum {} \; | sort | uniq -D --check-chars=32
}

# Aliases
alias grep='grep --color=auto'
alias rm='rm -iv'
alias ls='ls --color=auto --human-readable --group-directories-first'
alias md='mkdir'
alias rd='rm -r'
for bin in cp mv mkdir chmod chown; do
    alias $bin="$bin -v"
done
alias c='clear'
alias diff='colordiff'
alias pkgup='pikaur -Syu'
alias pkgins='pikaur -S'
alias pkgrem='pikaur -Rns'
alias pkgsearch='pikaur -Ss'
alias g='git'
alias s='ack --with-filename'
alias sp='ack --with-filename --type=php'

export EDITOR=vim
export TERM=xterm-256color

# fzf
export FZF_DEFAULT_COMMAND="find . -not -path '*/\.git/*'"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.dotfiles/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Solarized colors for directory lisintg (https://github.com/seebi/dircolors-solarized)
eval `dircolors $HOME/.dotfiles/dircolors-solarized/dircolors.256dark`
