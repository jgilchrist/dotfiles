# /usr/bin aliases
alias mv="mv --interactive --verbose"
alias cp="cp --interactive --verbose"
alias mkdir="mkdir --parents --verbose"
alias ls="ls --human-readable --color=auto --indicator-style=slash --group-directories-first --no-group"
alias ll="ls -l"
alias la="ls --almost-all"
alias lla="ls -l --almost-all"

# Trailing space allows alias expansion in arguments
alias sudo="sudo "

# vim commands for terminal
alias :q="exit"

# Addition of default arguments
alias bat="bat --wrap=never"
alias gdb="gdb -q"
alias grep="grep --color"
alias make="make --no-print-directory"
alias rg="rg --smart-case --colors path:fg:green --colors line:fg:black --colors line:style:bold"
alias tree="tree --dirsfirst -F -I '.git|build'"
alias units="units --verbose --one-line"
alias dc="docker-compose"
alias k9s="k9s --readonly"
alias dust="dust --reverse"

# Misc

# If tokei is installed, alias 'cloc' to it
if type -q tokei
    alias cloc="tokei --sort=code"
end

# MacOS sets hostnames dynamically. Since keychain uses the hostname
# to keep track of environment variables, changing hostnames will
# cause it to lose track. Instead, specify a custom hostname
# to be used for all commands.
alias keychain="keychain --host jgilchrist"
