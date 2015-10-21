# Other config files
. ~/.bash/aliases
. ~/.bash/colors

# Turns a newline-separated list of values into a colon separated list of values
# for use with (for example) FIGNORE which requires a colon separated list of values.
colonise() {
    cat $1 | tr "\n" ":"
}

# Machine-specific modifications to the environment
[ -f "${HOME}/.env" ] && source "${HOME}/.env"

# User's binary directory
[ -d "${HOME}/bin" ] && export PATH="${HOME}/bin:$PATH"

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
