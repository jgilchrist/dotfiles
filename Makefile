COMMON := bash git scripts tmux vim
EXTRA := bspwm fish
ALL := $(COMMON) $(EXTRA)

.PHONY: $(ALL)

.PHONY: usage
usage:
	@echo 'Usage:'
	@echo '    make folder      Install an individual folder of dotfiles'
	@echo '    make group       Install a preset list of dotfiles'
	@echo '    make all         Install all dotfiles'
	@echo
	@echo 'Groups:'
	@echo '    common           ($(COMMON))'
	@echo '    extra            ($(EXTRA))'

.PHONY: common extra all
common: $(COMMON)
extra: $(EXTRA)
all: $(ALL)

bash:
	stow bash
bspwm:
	stow bspwm
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
