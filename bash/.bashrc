# Other config files
. ~/.bash/aliases
. ~/.bash/prompt

# Machine-specific modifications to the environment
[ -f "${HOME}/.env" ] && source "${HOME}/.env"

# User's binary directory
[ -d "${HOME}/bin" ] && export PATH="${HOME}/bin:$PATH"

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Always save 10000 history, without duplicates
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Ignore some file extensions
export FIGNORE=`colonise ${HOME}/.bash/fignore`

# Command options
export LESS='-R'

# Editor
export EDITOR='vim'
