#!/bin/bash

. $DOTFILES_PATH/lib/utils.sh

function uninstall_dotfiles() {
    start_msg "uninstalling dotfiles..."

    for i in $(find $DOTFILES_PATH -name uninstall.sh); do
        . $i &
        wait $!
    done;

    done_msg "uninstalling dotfiles"
}

function install_brew() {
    start_msg "installing homebrew..."

    if test ! $(which brew); then
        echo "installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    done_msg "installing homebrew"
}

function install_brew_packages() {
    start_msg "installing brew packages..."

    brew update
    brew bundle

    done_msg "installing brew packages"
}

function install_dotfiles {
    start_msg "installing dotfiles..."

    for i in $(find $DOTFILES_PATH -name install.sh | exclude_symlink_install); do
        . $i &
        wait $!
    done;

    # symlinks must be run last
    . $DOTFILES_PATH/link/install.sh

    done_msg "installing dotfiles"
}

function create_zshenv {
    start_msg "creating .zshenv from .env files..."

    # writes a warning for .zshenv
    rm -rf $DOTFILES_PATH/link/.zshenv
    echo "# This is an auto-generated file please do not modify\n" > $DOTFILES_PATH/link/.zshenv

    # this writes the brew env file first
    echo "\n# $DOTFILES_PATH/brew/.env\n" >> $DOTFILES_PATH/link/.zshenv
    cat $DOTFILES_PATH/brew/.env | sed 's/#.*//g' | sed '/^\s*$/d' | sed 's/^/export /' >> "$DOTFILES_PATH/link/.zshenv"

    for i in $(find $DOTFILES_PATH -name .env | exclude_brew_env); do
        echo "\n# $i\n" >> $DOTFILES_PATH/link/.zshenv
        cat "$i" | sed 's/#.*//g' | sed '/^\s*$/d' | sed 's/^/export /' >> "$DOTFILES_PATH/link/.zshenv"
    done;

    done_msg "creating .zshenv from .env files"
}

function check {
    if [ ! -f .env ]; then
        error_msg ".env file is not exists, just copy .env.example to .env and fill it"
        exit 1
    fi

    for i in $(list_link_files); do
        if [ -f "$HOME/$i" ]; then
            info_msg "will be removed $HOME/$i"
        fi
    done;
    
    get_confirmation $1
}

if [ $1 = "install_brew" ]; then
    install_brew
elif [ $1 = "install_brew_packages" ]; then
    install_brew_packages
elif [ $1 = "install_dotfiles" ]; then
    install_dotfiles
elif [ $1 = "uninstall_dotfiles" ]; then
    uninstall_dotfiles
elif [ $1 = "create_zshenv" ]; then
    create_zshenv
elif [ $1 = "check" ]; then
    check $2
else
    error_msg "invalid command"
    exit 1
fi