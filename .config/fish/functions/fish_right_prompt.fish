function fish_right_prompt
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1
    set -g __fish_git_prompt_char_untrackedfiles "?"

    # The git prompt's default format is ' (%s)'.
    # We don't want the leading space.
    set -l vcs (fish_vcs_prompt '(%s)' 2>/dev/null)

    set -l duration "$cmd_duration$CMD_DURATION"
    if test $duration -gt 1000
        set duration (math $duration / 1000)s
    else
        set duration
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l venv (string replace -r '.*/' '' -- "$VIRTUAL_ENV")

    set_color normal
    string join " " -- $venv (set_color black)$duration(set_color normal) $vcs
end
