COMMON := bash git scripts tmux vim
EXTRA := fish
ALL := $(COMMON) $(EXTRA)

.PHONY: $(ALL)

usage: print-usage
common: $(COMMON)
extra: $(EXTRA)
all: $(ALL)

print-usage:
	@echo 'Usage:'
	@echo '    make folder      Install an individual folder of dotfiles'
	@echo '    make group       Install a preset list of dotfiles'
	@echo '    make all         Install all dotfiles'
	@echo
	@echo 'Groups:'
	@echo '    common           ($(COMMON))'
	@echo '    extra            ($(EXTRA))'

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