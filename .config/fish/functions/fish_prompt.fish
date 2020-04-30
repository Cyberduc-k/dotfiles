function fish_prompt
    set --local parts (string split / (pwd))
    set --local dir ""
    set --local project_type ""
    set --local git_branch (git branch ^/dev/null | grep \* | sed 's/* //')
    set --local prompt

    if test -e ./Cargo.toml
        set project_type "$project_type "
    end
    
    if test -e ./package.json
        set project_type "$project_type "
    end

    if test -e ./tsconfig.json
        set project_type "$project_type "
    end

    if test -e ./stack.yaml; or count ./*.cabal >/dev/null
        set project_type "$project_type "
    end

    for part in $parts[2..-1]
        set dir "$dir/$part"
    end

    if test -z $git_branch
        set git_branch ""
    end

    if test (string length $project_type) -gt 0
        set prompt $prompt (set_color -b 333)"$project_type "
        # set prompt $prompt (set_color 333 -b blue)""
    end

    set prompt $prompt (set_color normal -b blue)" $dir "

    if test (string length $git_branch) -gt 0
        # set prompt $prompt (set_color blue -b red)""
        set prompt $prompt (set_color normal -b red)"  $git_branch "
        # set prompt $prompt (set_color red -b normal)""
    else
        # set prompt $prompt (set_color blue -b normal)""
    end

    set prompt $prompt (set_color normal)"\n∈ "

    for part in $prompt
        echo -n -e $part
    end
end
