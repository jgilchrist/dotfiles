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
	@stow bash
	@echo "Installed bash"
bspwm:
	@stow bspwm
	@echo "Installed bspwm"
fish:
	@stow fish
	@echo "Installed fish"
git:
	@stow git
	@echo "Installed git"
scripts:
	@stow scripts
	@echo "Installed scripts"
tmux:
	@stow tmux
	@echo "Installed tmux"
vim:
	@stow vim
	@echo "Installed vim"
