DEFAULT := bash git scripts tmux vim
EXTRA := bspwm fish latex
ALL := $(DEFAULT) $(EXTRA)

.PHONY: default
default: $(DEFAULT)

.PHONY: $(ALL)

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
