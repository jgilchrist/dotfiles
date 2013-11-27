DOTFILES = $(PWD)
BACKUP = $(HOME)/.dotfiles.backup

all: make-backup-folder ack bash tmux git

make-backup-folder:
	rm -rf --interactive $(BACKUP)
	mkdir $(BACKUP)

ack:
	mv $(HOME)/.ackrc $(BACKUP)
	ln -s $(DOTFILES)/ackrc $(HOME)/.ackrc

bash:
	mv $(HOME)/.bashrc $(BACKUP)
	ln -s $(DOTFILES)/bashrc $(HOME)/.bashrc
	mv $(HOME)/.bash_aliases $(BACKUP)
	ln -s $(DOTFILES)/bash_aliases $(HOME)/.bash_aliases
	mv $(HOME)/.bash_prompt $(BACKUP)
	ln -s $(DOTFILES)/bash_prompt $(HOME)/.bash_prompt

git:
	mv $(HOME)/.gitconfig $(BACKUP)
	ln -s $(DOTFILES)/gitconfig $(HOME)/.gitconfig
	mv $(HOME)/.gitignore $(BACKUP)
	ln -s $(DOTFILES)/gitignore $(HOME)/.gitignore

tmux:
	mv $(HOME)/.tmux.conf $(BACKUP)
	ln -s $(DOTFILES)/tmux.conf $(HOME)/.tmux.conf

