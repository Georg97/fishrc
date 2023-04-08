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

    set -l is_git_repo (git rev-parse --is-inside-work-tree 2>/dev/null)
    if test -n "$is_git_repo"
        set_color cyan
        set -l cur_branch (git rev-parse --abbrev-ref HEAD)
        set -l upstream (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
        if test -n "$upstream"

            set -l change_matrix (git rev-list --left-right --count $cur_branch...$upstream | string split \t)
            set -l npush $change_matrix[1]
            set -l npull $change_matrix[2]
            set -l nchanges (git status --porcelain | wc -l)
            printf " ($cur_branch"
            if test $npush -gt 0
                set_color blue
                printf " ↑$npush"
                set_color cyan
            end
            if test $npull -gt 0
                set_color yellow
                printf " ↓$npull"
                set_color cyan
            end
            if test $nchanges -gt 0
                set_color red
                printf " ↑↓$nchanges" 
                set_color cyan
            end
            if test $npush -eq 0 -a $npull -eq 0 -a $nchanges -eq 0
                set_color green
                printf " ✓"
                set_color cyan
            end
            printf ")"
        else
            printf " (%s)" $cur_branch
        end
    end

    set -l ram_usage (free -h | awk 'NR==2{print $3 "/" $2}')
    set_color magenta
    printf " $ram_usage"
    # Line 2
    echo
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(path basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end
function fish_right_prompt
    printf '%s %s%s' (date +%H:%M) (get_batp)
end

