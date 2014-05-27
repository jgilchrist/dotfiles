# Other config files
. ~/.bash_aliases
. ~/.bash_prompt

# Machine-specific modifications to the path
if [ -f "${HOME}/.path" ]; then
    . "${HOME}/.path"
fi

if [ -d "${HOME}/bin" ]; then
    export PATH="${HOME}/bin:$PATH"
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Always use a 256 color terminal
if [ "$TERM" != "screen-256color" ]; then
    export TERM="xterm-256color"
fi

# Always save 10000 history, without duplicates
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Command options
export GREP_OPTIONS="--color"
export LESS='-R'

# Other config
export NOSE_REDNOSE=1
