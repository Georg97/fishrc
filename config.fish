if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color yellow
    printf '%s' $USER
    set_color normal
    printf ' at '

    set_color magenta
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    set -l git_prompt (fish_git_prompt '%s')
    if test -n $git_prompt
        set_color cyan
        printf " ($git_prompt)"
    end

    # Line 2
    echo
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(path basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end
function fish_right_prompt
    printf '%s %s%s' (date +%H:%M) (batp) %
end

