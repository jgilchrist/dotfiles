CONFIGS = dirs bash git tmux vim

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

.PHONY: dirs
dirs:
	mkdir -p ~/.local/bin

.PHONY: bash
bash:
	mkdir -p ~/.bash
	stow bash
	touch ~/.env.local
	cp --no-clobber ~/.bash/prompts/prompt.default ~/.prompt

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
	mkdir -p ~/.vim/tmp
	mkdir -p ~/.vim/tmp/backup
	mkdir -p ~/.vim/tmp/swap
	mkdir -p ~/.vim/tmp/undo
	curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
	stow vim
	touch ~/.vim/plugins.local
	touch ~/.vim/vimrc.local
