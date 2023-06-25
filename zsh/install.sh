#!/bin/bash

. $DOTFILES_PATH/lib/utils.sh

start_msg "installing oh-my-zsh..."


# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

info_msg "installed: oh-my-zsh"
export ZSH_CUSTOM=~/.oh-my-zsh/custom

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

info_msg "installed: powerlevel10k theme"

# auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

info_msg "installed: zsh-autosuggestions plugin"

# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

info_msg "installed: zsh-syntax-highlighting plugin"

done_msg "installing oh-my-zsh"