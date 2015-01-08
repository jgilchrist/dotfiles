ALL := bash fish git scripts tmux vim

all: $(ALL)
.PHONY: $(ALL)

bash:
	stow bash
fish:
	stow fish
git:
	stow git
scripts:
	stow scripts
tmux:
	stow tmux
vim:
	stow vim
