#!/bin/bash
#
# create symlinks for the config files
#
# author: Jonas Hantelmann
# date: 2013/08/10
#

FILES=(".vim .vimrc .zshrc")

for file in $FILES; do
    read -p "Create symlink $HOME/$file ? [Y/n] " CONFIRM

    if [ "$CONFIRM" = "Y" ] || [ "$CONFIRM" = "y" ] || [ -z "$CONFIRM" ]; then
        unset $CONFIRM

        ln -vs $(dirname `realpath $0`)/$file $HOME/$file
    fi
done
