all: clean bootstrap

clean:
	./lib/utils.sh remove_symlinks
	./lib/utils.sh remove_oh_my_zsh

bootstrap:
	./bootstrap.sh
	zsh

install_brew:
	./bootstrap.sh brew	

install_brew_packages:	
	./bootstrap.sh brew-packages

install_dotfiles:
	./bootstrap.sh dotfiles

bootstrap_symlinks:
	./bootstrap.sh bootstrap-symlinks

install_dotfiles_symlinks: install_dotfiles bootstrap_symlinks