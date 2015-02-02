COMMON := bash git scripts tmux vim
EXTRA := bspwm fish latex
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
	@stow -R bash
	@echo "Installed bash"
bspwm:
	@stow -R bspwm
	@echo "Installed bspwm"
fish:
	@stow -R fish
	@echo "Installed fish"
git:
	@stow -R git
	@echo "Installed git"
latex:
	@stow -R latex
	@echo "Installed latex"
scripts:
	@stow -R scripts
	@echo "Installed scripts"
tmux:
	@stow -R tmux
	@echo "Installed tmux"
vim:
	@stow -R vim
	@echo "Installed vim"
