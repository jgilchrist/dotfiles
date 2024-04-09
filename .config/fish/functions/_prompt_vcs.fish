function _prompt_vcs
    set -g __fish_git_prompt_color_branch brblack

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_char_untrackedfiles "?"
    set -g __fish_git_prompt_char_stateseparator ''

    fish_vcs_prompt ' %s' 2>/dev/null
end

function _prompt_vcs_loading_indicator
    echo ' ' (set_color black)…(set_color normal)
end
