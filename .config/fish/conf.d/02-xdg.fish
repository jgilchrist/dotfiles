# Set up XDG base dirs
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc

if type -q rg
    set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/config
end

if type -q dotnet
    set -gx DOTNET_CLI_HOME "$XDG_DATA_HOME"/dotnet
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
