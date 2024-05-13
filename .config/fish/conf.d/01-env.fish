set fish_greeting

test -d $HOME/.dotnet/tools && fish_add_path $HOME/.dotnet/tools
test -d $HOME/.local/bin && fish_add_path $HOME/.local/bin

set -gx BROWSER open

set -gx LESS "--quit-if-one-screen --ignore-case --raw-control-chars --chop-long-lines --hilite-unread --no-init"

set -gx LESSHISTFILE -

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

set -gx HOMEBREW_NO_UPDATE_REPORT_NEW 1

if type -q zellij
    alias z="zellij"
end

# }}}
