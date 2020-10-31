#!/bin/sh

set -e

if tmux has-session -t=dotfiles 2> /dev/null; then
  tmux attach -t dotfiles
  exit
fi

tmux new-session -d -s dotfiles -n vim -x $(tput cols) -y $(tput lines)

tmux split-window -t dotfiles:vim -h

tmux send-keys -t dotfiles:vim.left "vim ." Enter
tmux send-keys -t dotfiles:vim.right "git s" Enter

tmux attach -t dotfiles:vim.right