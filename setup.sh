#!/bin/bash
#
# create symlinks for the config files
#
# author: Jonas Hantelmann
# date: 2013/08/10
#

FILES=(".vimrc .zshrc .Xresources")

for file in $FILES; do
    read -p "Create symlink $HOME/${file} ? [Y/n] " CONFIRM

    if [ "$CONFIRM" = "Y" ] || [ "$CONFIRM" = "y" ] || [ -z "$CONFIRM" ]; then
        unset $CONFIRM

        ln -vs $file $HOME/${file}
    fi
done
