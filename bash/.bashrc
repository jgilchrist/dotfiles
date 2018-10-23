export EDITOR='vim'

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
alias prettier="prettier --trailing-comma es5 --single-quote --print-width 100 --write"
alias rg="rg --smart-case --colors path:fg:green --colors line:fg:black --colors line:style:bold"

# Shorter versions of commonly typed commands
alias sys="systemctl"

# MacOS sets hostnames dynamically. Since keychain uses the hostname
# to keep track of environment variables, changing hostnames will
# cause it to lose track. Instead, specify a custom hostname
# to be used for all commands.
alias keychain="keychain --host jgilchrist"

# Small 'functions'
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ve="source .venv/bin/activate"
alias stopwatch="time read"
# }}}

# Colors {{{
export COLOR_RESET="\e[0m"
export COLOR_BLACK="\e[30m"
export COLOR_RED="\e[31m"
export COLOR_GREEN="\e[32m"
export COLOR_YELLOW="\e[33m"
export COLOR_BLUE="\e[34m"
export COLOR_VIOLET="\e[35m"
export COLOR_CYAN="\e[36m"
export COLOR_LIGHT_GRAY="\e[37m"
export COLOR_DARK_GRAY="\e[90m"
export COLOR_LIGHT_RED="\e[91m"
export COLOR_LIGHT_GREEN="\e[92m"
export COLOR_LIGHT_YELLOW="\e[93m"
export COLOR_LIGHT_BLUE="\e[94m"
export COLOR_LIGHT_VIOLET="\e[95m"
export COLOR_LIGHT_CYAN="\e[96m"
export COLOR_WHITE="\e[97m"
# }}}

. ~/.prompt

# Machine-specific modifications to the environment
[ -f "${HOME}/.env.local" ] && source "${HOME}/.env.local"

# vim: set fdm=marker:
