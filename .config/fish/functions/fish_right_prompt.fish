function fish_right_prompt
    set -l duration "$cmd_duration$CMD_DURATION"
    set -l lastprompt "$history[1]"

    # Only show the command duration for long commands, but also ignore commands which
    # tend to take a long time but aren't interesting (e.g. editors)
    if string match --regex --invert --quiet "^(vim|nvim|fg).*" $lastprompt
        set showduration
    end

    if test $duration -gt 10000 && set -q showduration
        set duration (set_color yellow)(math $duration / 1000)s(set_color normal)' '
    else
        set duration
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l venv (string replace -r '.*/' '' -- "$VIRTUAL_ENV")

    echo -n -s $duration $venv (set_color blue) (prompt_pwd --dir-length=3) (set_color normal)
end
