export EDITOR="vim"

[ -d "${HOME}/.local/share/zsh/site-functions" ] && fpath=($fpath ~/.local/share/zsh/site-functions)
[ -d "${HOME}/.config/zsh/prompt" ] && fpath=($fpath ~/.config/zsh/prompt)

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U edit-command-line
autoload -U promptinit; promptinit; prompt pure

set -o vi
# Setup backspace to work correctly in vim mode
bindkey "^?" backward-delete-char

# Prevent duplicates in $PATH
typeset -gU path

# Ensure local binaries are on the path
[ -d "${HOME}/.local/bin" ] && path=(~/.local/bin $path)

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Ignore Ctrl-S/Ctrl-Q to avoid locking terminals
stty -ixon

zle -N edit-command-line
bindkey "^xe" edit-command-line
bindkey "^x^e" edit-command-line

HISTFILE="${HOME}/.zhistory"
HISTSIZE="1000000"
SAVEHIST="1000000"

setopt EXTENDED_HISTORY             # Write to the history file in the format ":start:elapsed;command"
setopt INC_APPEND_HISTORY           # Write to the history file immediately
setopt SHARE_HISTORY                # Share history between all ZSH sessions
setopt HIST_EXPIRE_DUPS_FIRST       # Expire duplicate entries first
setopt HIST_IGNORE_DUPS             # Don't write duplicate entries
setopt HIST_IGNORE_ALL_DUPS         # Delete old entries if the new entry is a duplicate
setopt HIST_SAVE_NO_DUPS            # Don't write duplicate entries to the history file
setopt GLOBDOTS                     # Allow matching files that begin with . without specifying .

unsetopt BEEP                       # Turn off terminal bells
unsetopt LIST_BEEP                  # Turn off autocomplete bells
unsetopt CLOBBER                    # Force using >! and >>! to overwrite existing files

zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"

# Ignore some file extensions
export FIGNORE=".localized:.DS_Store"

# Never store history for less
export LESSHISTFILE=-

# Set some default LESS options
export LESS="--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

# Functions and aliases {{{
function scratch() {
  local SCRATCH=$(mktemp -d)
  echo "Spawing subshell in scratch directory: $SCRATCH"
  (cd $SCRATCH; zsh)
  echo "Removing scratch directory"
  rm -rf "$SCRATCH"
}

function load_dir_aliases() {
    local DIRS_SOURCE_FILE="$1"
    local DIRS_GEN_FILE=$(mktemp)

    touch ${DIRS_GEN_FILE}
    chmod +x ${DIRS_GEN_FILE}
    echo -n "" >! ${DIRS_GEN_FILE}

    while read dir; do
        local name=$(echo $dir | cut -d: -f1)
        local location=$(echo $dir | cut -d: -f2)
        echo "hash -d $name=$location" >> ${DIRS_GEN_FILE}
    done < ${DIRS_SOURCE_FILE}

    source ${DIRS_GEN_FILE}
    rm ${DIRS_GEN_FILE}
}

# /usr/bin aliases
alias mv="mv --interactive --verbose"
alias cp="cp --interactive --verbose"
alias mkdir="mkdir --parents --verbose"
alias ls="ls --human-readable --color=auto --indicator-style=slash --group-directories-first"
alias ll="ls -l"
alias la="ls --almost-all"
alias lla="ls -l --almost-all"

# Trailing space allows alias expansion in arguments
alias sudo="sudo "

# vim commands for terminal
alias :q="exit"

# Addition of default arguments
alias bat="bat --wrap=never"
alias gdb="gdb -q"
alias grep="grep --color"
alias make="make --no-print-directory"
alias rg="rg --smart-case --colors path:fg:green --colors line:fg:black --colors line:style:bold"
alias tree="tree --dirsfirst -F -I '.git|build'"
alias units="units --verbose --one-line"
alias dc="docker-compose"
alias k9s="k9s --readonly"
alias dust="dust --reverse"

# MacOS sets hostnames dynamically. Since keychain uses the hostname
# to keep track of environment variables, changing hostnames will
# cause it to lose track. Instead, specify a custom hostname
# to be used for all commands.
alias keychain="keychain --host jgilchrist"
# }}}


# Machine-specific modifications to the environment
[ -f "${HOME}/.local/env" ] && source "${HOME}/.local/env"

# Machine-local directory aliases from ~/.local/dirs
[ -f "${HOME}/.local/dirs" ] && load_dir_aliases "${HOME}/.local/dirs"

# Tool-specific configuration/aliases {{{
# This needs to come after .local/env as .local/env may add these tools to the path

# If FZF is installed, use it
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh

    # If fd is installed, use it for FZF
    if (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude '.git/**'"
    fi
fi

if (( $+commands[brew] )); then
    export HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED=1
fi

# If ripgrep is installed, configure its config file
if (( $+commands[rg] )); then
    export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"
fi

# If tokei is installed, alias 'cloc' to it
if (( $+commands[tokei] )); then
    alias cloc="tokei --sort=code"
fi

if (( $+commands[docker] )); then
    export COMPOSE_DOCKER_CLI_BUILD=1
    export DOCKER_BUILDKIT=1
fi

if (( $+commands[curlie] )); then
    alias http="curlie"
    alias https="curlie --https"
fi

# }}}

# vim: set fdm=marker:
