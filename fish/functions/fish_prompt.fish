# set __fish_git_prompt_showdirtystate 1
# set __fish_git_prompt_showuntrackedfiles 1
# set __fish_git_prompt_showupstream 1

set __fish_git_prompt_show_informative_status 1

set __fish_git_prompt_char_dirtystate '⚡ '
set __fish_git_prompt_char_stagedstate '● '
set __fish_git_prompt_char_stashstate '↩ '

set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_color_upstream cyan

function fish_prompt --description 'Write out the prompt'

    echo

	# PWD
	set_color $fish_color_cwd
	printf '%s' (prompt_pwd)
	set_color normal

	printf '%s ' (__fish_git_prompt)

	echo -n '▶ '

end
