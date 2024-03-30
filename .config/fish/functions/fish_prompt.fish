function fish_prompt
    set -l last_status $status

    set -l normal (set_color normal)
    set -l usercolor (set_color $fish_color_user)

    set -l delimcolor (set_color yellow)
    test $last_status -ne 0; and set delimcolor (set_color red)
    set -l delim '❱'

    fish_is_root_user; and set delim "#"

    set -l cwd (set_color $fish_color_cwd)

    # Only show host if in SSH or container
    # Store this in a global variable because it's slow and unchanging
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$hostname$normal":"
        end
    end

    # Shorten pwd if prompt is too long
    set -l pwd (prompt_pwd --dir-length=3)

    echo
    echo -n -s $prompt_host $cwd $pwd $normal
    echo
    echo -n -s $delimcolor$delim$normal ' '
end
