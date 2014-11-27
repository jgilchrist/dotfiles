. ~/.aliases

# ls aliases
alias ls='ls --color=auto -p --group-directories-first'
alias la='ls -a'
alias ll='ls -l'

alias grep="grep --color"

alias b='cd ..; pwd'

# vim commands for terminal
alias :x="exit"
alias :q="exit"

alias todo="ack 'todo:'"

alias make="make --no-print-directory"

# helper programs
alias pdf="google-chrome"
alias ccat="pygmentize -g"

function create() {
    mkdir -p $1 && cd $1; pwd
}
