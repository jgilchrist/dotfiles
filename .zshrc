export EDITOR='vim'

[ -d "${HOME}/.local/share/completions" ] && fpath=(~/.local/share/completions $fpath)

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U edit-command-line

# Prevent duplicates in $PATH
typeset -gU path

# Ensure local binaries are on the path
[ -d "${HOME}/.local/bin" ] && path=(~/.local/bin $path)

# Always use a 256 color terminal
[ "$TERM" != "screen-256color" ] && export TERM="xterm-256color"

# Ignore Ctrl-S/Ctrl-Q to avoid locking terminals
stty -ixon

zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

HISTFILE="${HOME}/.zhistory"
HISTSIZE="1000000"
SAVEHIST="1000000"

# Don't show % at the end of command output without a terminating '\n'
PROMPT_EOL_MARK=''

setopt EXTENDED_HISTORY             # Write to the history file in the format ":start:elapsed;command"
setopt INC_APPEND_HISTORY           # Write to the history file immediately
setopt SHARE_HISTORY                # Share history between all ZSH sessions
setopt HIST_EXPIRE_DUPS_FIRST       # Expire duplicate entries first
setopt HIST_IGNORE_DUPS             # Don't write duplicate entries
setopt HIST_IGNORE_ALL_DUPS         # Delete old entries if the new entry is a duplicate
setopt HIST_SAVE_NO_DUPS            # Don't write duplicate entries to the history file

unsetopt BEEP                       # Turn off terminal bells
unsetopt LIST_BEEP                  # Turn off autocomplete bells
unsetopt CLOBBER                    # Force using >! and >>! to overwrite existing files

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ignore some file extensions
export FIGNORE=".localized:.DS_Store"

# Never store history for less
export LESSHISTFILE=-

# Set some default LESS options
export LESS="--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

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
alias bat="bat --wrap=never"
alias gdb="gdb -q"
alias grep="grep --color"
alias make="make --no-print-directory"
alias rg="rg --smart-case --colors path:fg:green --colors line:fg:black --colors line:style:bold"
alias tree="tree --dirsfirst -F -I '.git|build'"
alias units="units --verbose --one-line"
alias dc="docker-compose"
alias k9s="k9s --readonly"

# MacOS sets hostnames dynamically. Since keychain uses the hostname
# to keep track of environment variables, changing hostnames will
# cause it to lose track. Instead, specify a custom hostname
# to be used for all commands.
alias keychain="keychain --host jgilchrist"

# Small 'functions'
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
# }}}

. ~/.prompt

# Machine-specific modifications to the environment
[ -f "${HOME}/.env.local" ] && source "${HOME}/.env.local"

# Tool-specific configuration/aliases {{{
# This needs to come after .env.local as .env.local may add these tools to the path

# If FZF is installed, use it
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh

    # If fd is installed, use it for FZF
    if (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND='fd --type file'
    fi
fi

# If ripgrep is installed, configure its config file
if (( $+commands[rg] )); then
    export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"
fi

# If tokei is installed, alias 'cloc' to it
if (( $+commands[tokei] )); then
    alias cloc="tokei --sort=code"
fi

# }}}

# vim: set fdm=marker: