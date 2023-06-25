#!/bin/bash

function escape_slashes {
    sed 's/\//\\\//g' 
}

function escape_dots {
    sed 's/\./\\\./g'
}

function exclude_special_files {
    grep -vw  -- 'install.sh' | grep -vw  -- 'uninstall.sh' | grep -vw  -- '.env' 
}

function exclude_symlink_install {
    grep -vw  -- 'link/install.sh'
}

function exclude_brew_env {
    grep -vw  -- 'brew/.env'
}

function list_link_files {
    ls -A link | exclude_special_files
}

function get_confirmation {
    if [ "$1" != "--confirmation" ]; then
        return 0
    fi

    read -p "Are you sure? [y/N] " -n 1 -r
    echo
    case "$REPLY" in 
    n|N ) error_msg "cancelled"; exit 1;;
    y|Y ) ;;
    * ) error_msg "invalid command"; get_confirmation;;
    esac
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

function error_msg {
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    printf "${RED}[ERROR]${NC} $1\n" >&2
}

function info_msg {
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
    printf "${CYAN}[INFO]${NC} $1\n"
}

function load_dotenv {
    if [ -f .env ]; then
        export $(cat $DOTFILES_PATH/.env | sed 's/#.*//g' | xargs)
    else
        error_msg ".env file does not exist"
        exit
    fi
}

function update_environment_variable {
    local variable_name=$1
    local variable_value=$(echo $2 | escape_slashes | escape_dots)
    local file_path=$3

    if [ -z "$variable_name" ]; then
        error_msg "Variable name is required"
        return 1
    fi

    if [ -z "$variable_value" ]; then
        error_msg "Variable value is required"
        return 1
    fi

    if [ -z "$file_path" ]; then
        error_msg "File path is required"
        return 1
    fi

    if [ ! -f "$file_path" ]; then
        error_msg "File does not exist"
        return 1
    fi

    if [ -z "$(grep $variable_name $file_path)" ]; then
        error_msg "Variable does not exist"
        return 1
    fi

    sed -i '' "s/^export $variable_name=.*/export $variable_name=$variable_value/" $file_path
}


if [ "$(type -t $*)" = 'function' ]; then
    $*
fi
