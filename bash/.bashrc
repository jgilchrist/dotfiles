# Other config files
. ~/.bash/aliases
. ~/.bash/colors
. ~/.bash/prompts/simple

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

# User's binary directory
[ -d "${HOME}/bin" ] && pathprepend "${HOME}/bin"

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Always save 10000 history, without duplicates
export HISTCONTROL=erasedups
export HISTSIZE=10000

# Ensure that history is preserved if more than one instance of bash is run
shopt -s histappend

# Ignore some file extensions
export FIGNORE=`colonise ${HOME}/.bash/fignore`

# Always color less output
export LESS='-R'

# Never store history for less
export LESSHISTFILE=-

# Editor
export EDITOR='vim'
