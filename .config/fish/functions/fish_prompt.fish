function fish_prompt
    set -l delimcolor (set_color yellow)
    test $status -ne 0; and set delimcolor (set_color red)

    set -l delim '❱'
    fish_is_root_user; and set delim "#"

    # Only show host if in SSH or container
    # Store this in a global variable because it's slow and unchanging
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set prompt_host (set_color $fish_color_user)$USER(set_color normal)@(set_color $fish_color_host)$hostname(set_color normal)":"
        end
    end

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

    echo
    echo -n -s $prompt_host (set_color $fish_color_cwd) (prompt_pwd --dir-length=3) (set_color normal) ' ' (_prompt_vcs)
    echo
    echo -n -s $delimcolor$delim(set_color normal) ' '
end
