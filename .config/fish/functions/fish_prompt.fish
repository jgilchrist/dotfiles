function fish_prompt
    set -l delimcolor (set_color yellow)
    test $status -ne 0; and set delimcolor (set_color red)

    set -l delim '$'
    fish_is_root_user; and set delim '#'

    set -l bg_jobs_indicator ''
    set -l bg_jobs (count (jobs))
    if test $bg_jobs -gt 0
        set bg_jobs_indicator (set_color black)'*'$bg_jobs' '
    end

    # Only show host if in SSH or container
    # Store this in a global variable because it's slow and unchanging
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end

            set -g prompt_host (set_color green)$USER(set_color normal)"@"(set_color yellow)$hostname(set_color normal)' '
        end
    end

    echo
    echo -n -s $prompt_host $bg_jobs_indicator $delimcolor$delim(set_color normal) ' '
end
