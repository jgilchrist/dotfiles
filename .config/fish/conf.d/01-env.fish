set fish_greeting

# Set up XDG base dirs
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

test -d $HOME/.dotnet/tools && fish_add_path $HOME/.dotnet/tools
test -d $HOME/.cargo/bin && fish_add_path $HOME/.cargo/bin

test -d $HOME/.local/bin && fish_add_path $HOME/.local/bin

set -gx LESS "--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

set -gx LESSHISTFILE -
set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc

# Tool-specific configuration/aliases {{{
# This needs to come after .local/env as .local/env may add these tools to the path

# If fd is installed, use it for FZF
if type -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden --exclude '.git/**'"
end

if type -q nvim
    set -gx EDITOR "nvim"
    alias vim="nvim"
else
    set -gx EDITOR "vim"
end

# If ripgrep is installed, configure its config file
if type -q rg
    set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/config
end

# If tokei is installed, alias 'cloc' to it
if type -q tokei
    alias cloc="tokei --sort=code"
end

if type -q dotnet
    set -gx MSBUILDTERMINALLOGGER auto
end

if type -q docker
    set -gx COMPOSE_DOCKER_CLI_BUILD 1
    set -gx DOCKER_BUILDKIT 1
end

# }}}
