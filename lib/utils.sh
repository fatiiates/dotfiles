#!/bin/sh

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
