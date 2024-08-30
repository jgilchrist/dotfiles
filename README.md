# Installation

Installation requires GNU `stow`, a symlink farm manager. Install it using your favourite package manager.

```sh
git clone https://github.com/jgilchrist/dotfiles ~/.dotfiles
cd ~/.dotfiles && ./install
```

# Machine-local configuration

Any configuration which shouldn't be shared between machines should be placed in the following files:

* `~/.local/env`
* `~/.local/gitconfig`
* `~/.config/nvim/jg/local.lua`
