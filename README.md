# dotfiles

These dotfiles are managed using `GNU Stow`, a symlink farm manager. Install it using your favourite package manager.

### Getting the dotfiles

```sh
git clone https://github.com/jgilchrist/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### Install a config

```sh
stow <config> # e.g. stow bash
```

### Uninstall a config

```sh
stow --delete <config>
```

### Install a config to /

```sh
stow --target=/ <config>
```
