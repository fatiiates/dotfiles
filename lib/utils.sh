#!/bin/sh

function escape_slashes {
    sed 's/\//\\\//g' 
}

function escape_dots {
    sed 's/\./\\\./g'
}

function start_msg {
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
    printf "${BLUE}[START]${NC} $1\n"
}

function done_msg {
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}[DONE]${NC} $1\n"
}

function update_environment_variable {
    local variable_name=$1
    local variable_value=$(echo $2 | escape_slashes | escape_dots)
    local file_path=$3

    if [ -z "$variable_name" ]; then
        echo "Variable name is required"
        return 1
    fi

    if [ -z "$variable_value" ]; then
        echo "Variable value is required"
        return 1
    fi

    if [ -z "$file_path" ]; then
        echo "File path is required"
        return 1
    fi

    if [ ! -f "$file_path" ]; then
        echo "File does not exist"
        return 1
    fi

    if [ -z "$(grep $variable_name $file_path)" ]; then
        echo "Variable does not exist"
        return 1
    fi

    sed -i '' "s/^export $variable_name=.*/export $variable_name=$variable_value/" $file_path
}

function create_symlinks {
    start_msg "creating symlinks..."

    for i in $(ls -A link); do
        ln -s $DOTFILES_PATH/link/$i ~/$i
    done;

    done_msg "creating symlinks"
}

function remove_symlinks {
    start_msg "removing symlinks..."

    for i in $(ls -A link); do
        rm ~/$i
    done;

    done_msg "removing symlinks"
}

function remove_oh_my_zsh {
    start_msg "removing oh-my-zsh..."

    rm -rf ~/.oh-my-zsh

    done_msg "removing oh-my-zsh"
}


if [ "$(type -t $*)" = 'function' ]; then
    $*
fi
