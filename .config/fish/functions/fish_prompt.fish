function fish_prompt
    get_pwd_prompt
    # printf " "
    # get_git_prompt
    printf "\n> "
end

function get_pwd_prompt
    set_color blue
    printf $PWD
    set_color normal
end

function get_git_prompt
    set -l git_branch (git branch ^/dev/null | grep \* | sed 's/* //')
    set -l git_status (git status --porcelain 2>/dev/null | string collect)
    set -l git_remote (git status --ahead-behind 2>/dev/null | string collect)
    set -l git_untracked (echo $git_status | grep "^\s*?" | wc -l)
    set -l git_modified (echo $git_status | grep "^\s*M" | wc -l)
    set -l git_added (echo $git_status | grep "^\s*A" | wc -l)
    set -l git_deleted (echo $git_status | grep "^\s*D" | wc -l)
    set -l git_ahead (echo $git_remote | grep "ahead" | grep -oP "(?<=by )[0-9]+")
    set -l git_behind (echo $git_remote | grep "behind" | grep -oP "(?<=by )[0-9]+")
    set -l G (set_color green)
    set -l B (set_color blue)
    set -l R (set_color red)
    set -l M (set_color purple)
    set -l Y (set_color yellow)
    set -l N (set_color normal)

    if not test -z $git_branch
        printf "$G""[""$M$git_branch$N"

        if not test -z $git_ahead; and test $git_ahead != "0"
            printf "↑$git_ahead"
        end

        if not test -z $git_behind; and test $git_behind != "0"
            printf "↓$git_behind"
        end

        if test $git_untracked != "0"
            printf " $Y?$git_untracked"
        end

        if test $git_modified != "0"
            printf " $B*$git_modified"
        end

        if test $git_added != "0"
            printf " $G+$git_added"
        end

        if test $git_deleted != "0"
            printf " $R-$git_deleted"
        end

        printf "$G""]""$N"
    end
end
