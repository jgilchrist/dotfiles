# Other config files
. ~/.bash/aliases
. ~/.bash/colors
. ~/.bash/functions
. ~/.bash/prompt

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

# Ensure that history is preserved if more than one instance of bash is run
shopt -s histappend

# Ensure that LINES and COLUMNS are set correctly
# This ensures that lines wrap correctly after the terminal is resized
shopt -s checkwinsize

# Ignore some file extensions
export FIGNORE=`colonise ${HOME}/.bash/fignore`

# Always color less output
export LESS='-R'

# Never store history for less
export LESSHISTFILE=-
