```
       mm                         mmmm      ##     mmmm
       ##              ##        ##"""      ""     ""##
  m###m##   m####m   #######   #######    ####       ##       m####m   mm#####m
 ##"  "##  ##"  "##    ##        ##         ##       ##      ##mmmm##  ##mmmm "
 ##    ##  ##    ##    ##        ##         ##       ##      ##""""""   """"##m
 "##mm###  "##mm##"    ##mmm     ##      mmm##mmm    ##mmm   "##mmmm#  #mmmmm##
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
