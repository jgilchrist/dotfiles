# Set up XDG base dirs
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

set -gx EDITOR vim

test -d $HOME/.dotnet/tools && fish_add_path $HOME/.dotnet/tools
test -d $HOME/.cargo/bin && fish_add_path $HOME/.cargo/bin

test -d $HOME/.local/bin && fish_add_path $HOME/.local/bin

set -gx LESS "--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

set -gx LESSHISTFILE -
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
