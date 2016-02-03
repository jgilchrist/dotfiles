ALL = ag bash git tmux vim

.PHONY: default
default: usage

.PHONY: all
all: $(ALL)

.PHONY: usage
usage:
	@echo "usage: make <target> {$(ALL)}"

.PHONY: ag
ag:
	stow ag

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
	stow vim
	touch ~/.vim/plugins.local
	touch ~/.vim/vimrc.local
