export EDITOR='vim'

autoload -U colors && colors
autoload -U compinit && compinit

# Add a directory to the beginning of the path if it is not already present
function pathprepend() {
    if [ -d "$1" ] && [[ ! "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
        PATH="$1${PATH:+":$PATH"}";
    fi
}

# Ensure local binaries are on the path
[ -d "${HOME}/.local/bin" ] && pathprepend "${HOME}/.local/bin"

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Save more history without duplicates, and preserve history if running more
# than one instance of bash
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
shopt -s histappend

# Ensure that LINES and COLUMNS are set correctly after resizing
shopt -s checkwinsize

# Ignore some file extensions
export FIGNORE=".localized:.DS_Store"

# Never store history for less
export LESSHISTFILE=-

# Functions and aliases {{{
function t() {
    local TMUX_SESSION_NAME="main"

    # If provided with args, pass them through.
    if [[ -n "$@" ]]; then
        tmux "$@"
        return
    fi

    # Attach to existing session, or create one.
    tmux new -A -s "$TMUX_SESSION_NAME"
}

# /usr/bin aliases
alias ls='ls -h --color=auto -p --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

# Trailing space allows alias expansion in arguments
alias sudo="sudo "

# vim commands for terminal
alias :q="exit"

# Addition of default arguments
alias grep="grep --color"
alias make="make --no-print-directory"
alias units="units --verbose --one-line"
alias toilet="toilet --font future"
alias tree="tree --dirsfirst -F -I '.git|build'"
alias gdb="gdb -q"
alias rg="rg --smart-case --colors path:fg:green --colors line:fg:black --colors line:style:bold"

# MacOS sets hostnames dynamically. Since keychain uses the hostname
# to keep track of environment variables, changing hostnames will
# cause it to lose track. Instead, specify a custom hostname
# to be used for all commands.
alias keychain="keychain --host jgilchrist"

# Small 'functions'
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
# }}}

. ~/.prompt

# Machine-specific modifications to the environment
[ -f "${HOME}/.env.local" ] && source "${HOME}/.env.local"

# vim: set fdm=marker:
