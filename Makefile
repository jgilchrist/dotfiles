ALL := bash git latex scripts tmux vim

.PHONY: default
default: $(ALL)

.PHONY: $(ALL)

bash:
	@stow -R bash
	@echo "Installed bash"
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
