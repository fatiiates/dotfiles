#!/bin/sh

source $DOTFILES_PATH/lib/utils.sh

start_msg "removing oh-my-zsh..."

info_msg "removing $HOME/.oh-my-zsh"
rm -rf $HOME/.oh-my-zsh

done_msg "removing oh-my-zsh"
