#!/bin/bash
#
# create symlinks for the config files
#
# author: Jonas Hantelmann <jonas@foodev.de>
# date: 2014-03-26
#

FILES=(".vim .vimrc .zshrc .conkyrc .conky-weather .gitconfig")

for file in $FILES; do
    read -p "Create symlink $HOME/$file ? [Y/n] " CONFIRM

    if [ "$CONFIRM" = "Y" ] || [ "$CONFIRM" = "y" ] || [ -z "$CONFIRM" ]; then
        unset $CONFIRM

        ln -vs $(dirname `realpath $0`)/$file $HOME/$file
    fi
done
