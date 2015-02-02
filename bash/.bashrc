# Other config files
. ~/.bash/aliases
. ~/.bash/prompts/at_in_on

# Machine-specific modifications to the path
[ -f "${HOME}/.path" ] && source "${HOME}/.path"

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

# Command options
export LESS='-R'

# Editor
export EDITOR='vim'
