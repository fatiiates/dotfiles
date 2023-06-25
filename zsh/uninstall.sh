#!/bin/sh

. $DOTFILES_PATH/lib/utils.sh

start_msg "removing oh-my-zsh..."

if [ -f "$HOME/.oh-my-zsh" ]; then
    info_msg "removing $HOME/.oh-my-zsh"
    rm -rf $HOME/.oh-my-zsh
fi

done_msg "removing oh-my-zsh"
