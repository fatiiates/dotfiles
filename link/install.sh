#!/bin/sh

. $DOTFILES_PATH/lib/utils.sh

start_msg "creating symlinks..."

for i in $(list_link_files); do
    ln -sf $DOTFILES_PATH/link/$i $HOME/$i
    info_msg "created symlink: $HOME/$i"
done;

done_msg "creating symlinks"