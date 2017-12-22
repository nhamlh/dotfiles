DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

init: symlink brew zsh

symlink:
	@ln -sf $(DIR)/zshrc ~/.zshrc
	@ln -sf $(DIR)/tmux ~/.tmux.conf
	@ln -sf $(DIR)/vim-config/entrypoint.vim ~/.vimrc

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew update
	@brew tap homebrew/bundle || echo ''
	@brew upgrade
	brew bundle --no-upgrade

zsh:
	@git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
	@git clone https://github.com/bhilburn/powerlevel9k ~/.oh-my-zsh/themes/powerlevel9k
