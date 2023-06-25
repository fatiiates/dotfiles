# define .env variables
ifneq (,$(wildcard ./.env))
    include .env
    export
endif
# include .env
# $(eval export $(shell sed -ne 's/ *#.*$$//; /./ s/=.*$$// p' .env))
.PHONY: all clean check install_brew install_brew_packages install_dotfiles create_zshenv

all: check_w_confirmation clean bootstrap
all_wout_brew: check_w_confirmation clean bootstrap_wout_brew

clean: check_w_confirmation remove

remove:
	${DOTFILES_PATH}/run uninstall_dotfiles

check_w_confirmation:
	${DOTFILES_PATH}/run check --confirmation

check:
	${DOTFILES_PATH}/run check

bootstrap: install_brew install_brew_packages install_dotfiles create_zshenv

bootstrap_wout_brew: install_dotfiles create_zshenv

install_brew:
	${DOTFILES_PATH}/run install_brew	

install_brew_packages:	
	${DOTFILES_PATH}/run install_brew_packages

install_dotfiles: create_zshenv
	${DOTFILES_PATH}/run install_dotfiles

create_zshenv:
	${DOTFILES_PATH}/run create_zshenv