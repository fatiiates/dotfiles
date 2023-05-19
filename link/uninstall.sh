#!/bin/sh

source $DOTFILES_PATH/lib/utils.sh

start_msg "removing symlinks..."

for i in $(list_link_files); do
    if [ -f "$HOME/$i" ]; then
        info_msg "removing $HOME/$i"
        rm -rf $HOME/$i
    fi
done;

done_msg "removing symlinks"
