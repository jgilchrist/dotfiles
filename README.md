These dotfiles are managed using `GNU Stow`, a symlink farm manager. Install it using your favourite package manager.

```sh
git clone https://github.com/jgilchrist/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Install a config
stow bash
stow git
# ...

# Uninstall a config
stow --delete bash

# Install a config to /
stow --target=/ bash
```
