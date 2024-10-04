function fish_right_prompt
    # Only show the command duration for long commands, but also ignore commands which
    # tend to take a long time but aren't interesting (e.g. editors)
    set -l duration_ms "$cmd_duration$CMD_DURATION"
    if test $duration_ms -gt 10000
        if string match --regex --invert --quiet "^(vim|nvim|fg|ssh)" "$history[1]"
            set duration (set_color yellow)(math $duration_ms / 1000)s(set_color normal)' '
        else
            set duration
        end
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l venv (string replace -r '.*/' '' -- "$VIRTUAL_ENV")

    echo -n -s $duration $venv (set_color blue) (prompt_pwd --dir-length=3) (set_color normal)
end
