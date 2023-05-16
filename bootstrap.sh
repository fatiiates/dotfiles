#!/bin/sh

source ./lib/utils.sh

export DOTFILES_PATH=${DOTFILES_PATH:-~/.dotfiles}

update_environment_variable "DOTFILES_PATH" $DOTFILES_PATH ./link/.zshenv

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

    for i in $(find . -name install.sh); do
        source $i &
        wait $!
    done;

    done_msg "installing dotfiles"
}

function bootstrap_symlinks() {
    start_msg "bootstrapping symlinks..."

    remove_symlinks

    create_symlinks

    done_msg "bootstrapping symlinks"
}

function install() {
    start_msg "STARTED"

    install_brew
    install_brew_packages
    install_dotfiles
    bootstrap_symlinks

    done_msg "DONE"
}

if [ $1 = "brew" ]; then
    install_brew
elif [ $1 = "brew-packages" ]; then
    install_brew_packages
elif [ $1 = "dotfiles" ]; then
    install_dotfiles
elif [ $1 = "bootstrap-symlinks" ]; then
    bootstrap_symlinks
else
    install
fi