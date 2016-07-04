CONFIGS = bash git tmux vim local

.PHONY: default
default: all

.PHONY: all
all: $(CONFIGS)

.PHONY: help
help: usage

.PHONY: usage
usage:
	@echo "usage: make <target>"
	@echo "targets: [all] $(CONFIGS)"

.PHONY: bash
bash:
	mkdir -p ~/.bash
	stow bash
	touch ~/.env.local

.PHONY: git
git:
	stow git

.PHONY: tmux
tmux:
	stow tmux

.PHONY: vim
vim:
	mkdir -p ~/.vim
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
	stow vim
	touch ~/.vim/plugins.local
	touch ~/.vim/vimrc.local

.PHONY: ctags
ctags:
	stow ctags

.PHONY: local
local:
	stow local
