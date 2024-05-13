# Set default dirs for parity on MacOS
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:=${HOME}/.local/state}

[ -d "${HOME}/.local/share/zsh/site-functions" ] && fpath=($fpath ~/.local/share/zsh/site-functions)
[ -d "${HOME}/.config/zsh/prompt" ] && fpath=($fpath ~/.config/zsh/prompt)

autoload -U colors && colors
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -U edit-command-line
autoload -U promptinit; promptinit; prompt pure

# Set vim keybindings
bindkey -v

# Don't wait to enter normal mode after pressing ESC
KEYTIMEOUT=1

# Setup backspace to work correctly in vim mode
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[4 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]]; then
    echo -ne '\e[2 q'
  fi
}

zle -N zle-keymap-select

zle-line-init() {
    echo -ne "\e[2 q"
}

zle -N zle-line-init

echo -ne '\e[2 q' # Use block cursor on startup.
preexec() { echo -ne '\e[2 q' ;} # Use block cursor for each new prompt.

# Prevent duplicates in $PATH
typeset -gU path

# Ensure some commonly seen directories are on the path
[ -d "${HOME}/.dotnet/tools" ] && path=(~/.dotnet/tools $path)
[ -d "${HOME}/.cargo/bin" ] && path=(~/.cargo/bin $path)

# Ensure local binaries are on the path
[ -d "${HOME}/.local/bin" ] && path=(~/.local/bin $path)

# Always use a 256 color terminal
[ "$TERM" != "tmux-256color" ] && export TERM="xterm-256color"

# Ignore Ctrl-S/Ctrl-Q to avoid locking terminals
stty -ixon

zle -N edit-command-line
bindkey "^xe" edit-command-line
bindkey "^x^e" edit-command-line

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


# Set some default LESS options
export LESS="--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

# Config file locations {{{

# Store zsh files in XDG directories
HISTFILE="${XDG_DATA_HOME}/zsh/history"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Never store history for less
export LESSHISTFILE=-

# Allow storing readline configuration under .config
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Miscellaneous XDG configuration
alias wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""
alias units="units --history $XDG_DATA_HOME/units_history"

# }}}

# Functions and aliases {{{
function tmpdir() {
  local SCRATCHDIR=$(mktemp -d -p "/tmp")
  echo "Spawing subshell in scratch directory: $SCRATCHDIR"
  (cd $SCRATCHDIR; zsh)
  echo "Removing scratch directory ($SCRATCHDIR)"
  rm -rf "$SCRATCHDIR"
}

# /usr/bin aliases
alias mv="mv --interactive --verbose"
alias cp="cp --interactive --verbose"
alias mkdir="mkdir --parents --verbose"
alias ls="ls --human-readable --color=auto --indicator-style=slash --group-directories-first --no-group"
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

# Machine-local additions to $PATH from ~/.local/path
[ -f "${HOME}/.local/path" ] && echo "Found ~/.local/path file to be migrated"

# Tool-specific configuration/aliases {{{
# This needs to come after .local/env as .local/env may add these tools to the path

# If fd is installed, use it for FZF
if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude '.git/**'"
fi

if (( $+commands[brew] )); then
    export HOMEBREW_NO_UPDATE_REPORT_NEW=1
fi

if (( $+commands[nvim] )); then
    export EDITOR="nvim"
    alias vim="nvim"
else
    export EDITOR="vim"
fi

# If ripgrep is installed, configure its config file
if (( $+commands[rg] )); then
    export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"
fi

# If tokei is installed, alias 'cloc' to it
if (( $+commands[tokei] )); then
    alias cloc="tokei --sort=code"
fi

if (( $+commands[dotnet] )); then
    export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
    export MSBUILDTERMINALLOGGER=auto
fi

if (( $+commands[docker] )); then
    export COMPOSE_DOCKER_CLI_BUILD=1
    export DOCKER_BUILDKIT=1
fi

if (( $+commands[zellij] )); then
    alias z="zellij"
fi

if (( $+commands[volta] )); then
    export VOLTA_HOME="$XDG_DATA_HOME"/volta
fi

if (( $+commands[redis-cli] )); then
    export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history"
fi

if (( $+commands[reveal-md] )); then
    function revealmd() {
        reveal-md $1 --watch --highlight-theme="github-dark"
    }
fi

# }}}

# vim: set fdm=marker:
