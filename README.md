```
  _____   ____ _______ ______ _____ _      ______  _____
 |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____|
 | |  | | |  | | | |  | |__    | | | |    | |__  | (___
 | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \
 | |__| | |__| | | |  | |     _| |_| |____| |____ ____) |
 |_____/ \____/  |_|  |_|    |_____|______|______|_____/

 # Dotfiles for bash, vim, git, tmux, etc.
```

# Installation

Installation requires GNU `stow`, a symlink farm manager. Install it using your favourite package manager.

```sh
git clone https://github.com/jgilchrist/dotfiles ~/.dotfiles
cd ~/.dotfiles
make
```

# Machine-local configuration

Any configuration which shouldn't be shared between machines should be placed in the following files:

* `~/.env.local`
* `~/.gitconfig.local`
* `~/.vim/vimrc.local`
* `~/.vim/plugins.local`

# Feedback

Suggestions and improvements [welcome!](https://github.com/jgilchrist/dotfiles/issues)
