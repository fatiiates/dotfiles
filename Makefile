# define .env variables
include .env
$(eval export $(shell sed -ne 's/ *#.*$$//; /./ s/=.*$$// p' .env))

all: clean bootstrap

clean:
	${DOTFILES_PATH}/run uninstall_dotfiles

bootstrap:
	${DOTFILES_PATH}/run
	zsh

install_brew:
	${DOTFILES_PATH}/run install_brew	

install_brew_packages:	
	${DOTFILES_PATH}/run install_brew_packages

install_dotfiles: create_zshenv
	${DOTFILES_PATH}/run install_dotfiles

create_zshenv:
	${DOTFILES_PATH}/lib/utils.sh create_zshenv