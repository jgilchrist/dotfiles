set fish_greeting

# Set up XDG base dirs
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

test -d $HOME/.local/bin && fish_add_path --move $HOME/.local/bin

set -gx BROWSER open

set -gx LESS "--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"
set -gx LESSHISTFILE -

# Tool-specific configuration/aliases {{{
# This needs to come after .local/env as .local/env may add these tools to the path

set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc

# If fd is installed, use it for FZF
if type -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden --exclude '.git/**'"
end

if type -q rg
    set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/config
end

if type -q nvim
    set -gx EDITOR "nvim"
    alias vim="nvim"
else
    set -gx EDITOR "vim"
end

if type -q jj
    COMPLETE=fish jj | source

    abbr --add j --position command -- jj 
    abbr --add jjwatch --position command -- "watch --color --no-wrap jj --ignore-working-copy log -r \"default\(\)\" --color=always"
end

if type -q dotnet
    set -gx DOTNET_CLI_HOME "$XDG_DATA_HOME"/dotnet
    test -d $HOME/.dotnet/tools && fish_add_path $HOME/.dotnet/tools
end

if type -q cargo
    test -d $HOME/.cargo/bin && fish_add_path $HOME/.cargo/bin
end

if type -q docker
    set -gx COMPOSE_DOCKER_CLI_BUILD 1
    set -gx DOCKER_BUILDKIT 1
end

if type -q brew
    set -gx HOMEBREW_NO_UPDATE_REPORT_NEW 1
    set -gx HOMEBREW_NO_ENV_HINTS 1
end

if type -q wget
    alias wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""
end

if type -q redis-cli
    set -gx REDISCLI_HISTFILE "$XDG_DATA_HOME"/redis/rediscli_history
end

if type -q volta
    set -gx VOLTA_HOME "$XDG_DATA_HOME"/volta
end

if type -q units
    alias units="units --history $XDG_DATA_HOME/units_history"
end

if type -q uv
    uv generate-shell-completion fish | source
end

if type -q zoxide
    set -x _ZO_ECHO 1
    zoxide init fish --cmd cd | source
end

# }}}
