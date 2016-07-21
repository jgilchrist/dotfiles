# Other config files
. ~/.bash/aliases
. ~/.bash/colors
. ~/.bash/prompt

# Turns a newline-separated list of values into a colon separated list of values
# for use with (for example) FIGNORE which requires a colon separated list of values.
colonise() {
    cat $1 | tr "\n" ":"
}

# Add a directory to the end of the path if it is not already present
pathappend() {
    if [ -d "$1" ] && [[ ! "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
        PATH="${PATH:+"$PATH:"}$1";
    fi
}

# Add a directory to the beginning of the path if it is not already present
pathprepend() {
    if [ -d "$1" ] && [[ ! "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
        PATH="$1${PATH:+":$PATH"}";
    fi
}

# Machine-specific modifications to the environment
[ -f "${HOME}/.env.local" ] && source "${HOME}/.env.local"

# Ensure local binaries are on the path
[ -d "${HOME}/.local/bin" ] && pathprepend "${HOME}/.local/bin"

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Editor
export EDITOR='vim'

# Always save 10000 history, without duplicates
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000

# Ignore some common commands
export HISTIGNORE="history*:cd*:exit:fg:bg:clear:ls:ll:\:q"

# Ensure that history is preserved if more than one instance of bash is run
shopt -s histappend

# Ignore some file extensions
export FIGNORE=`colonise ${HOME}/.bash/fignore`

# Always color less output
export LESS='-R'

# Never store history for less
export LESSHISTFILE=-

e() {
    if [ $# -gt 0 ]; then
        command gvim --remote-silent "$@"
    else
        command gvim "$@"
    fi
}
