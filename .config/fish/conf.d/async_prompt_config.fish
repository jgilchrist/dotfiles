function _fish_vcs
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1
    set -g __fish_git_prompt_char_untrackedfiles "?"

    # The git prompt's default format is ' (%s)'.
    # We don't want the leading space.
    set -l vcs (fish_vcs_prompt '%s' 2>/dev/null)
    echo $vcs
end

function _fish_vcs_loading_indicator
    echo (set_color black)…(set_color normal)
end

set async_prompt_functions _fish_vcs
