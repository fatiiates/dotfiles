# INSTALLATION

Whatever you want to do you should run check command at first:

    make check

If you are starting from over you can use directly:

    make

If you want to just install dotfiles configuration:

    make all_wout_brew

If you want to more deep knowledge you should check `Makefile`.

# DEDICATED FILES
## .env

You can configure environment variables with this file. 

- If you are defining on the project level you can use these variables when bootstrapping the dotfiles configuration also they will be appear on your `.zshenv` configuration.
- If you are using this file in the module then they will be included to your `.zshenv` file 

## install.sh

This file dedicated for INSTALLING a modules files, directories, dependencies...

## uninstall.sh

This file dedicated for REMOVING a modules files, directories, dependencies...