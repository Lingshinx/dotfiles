function trans
    set prompt 'echo -n \n(set_color bryellow)"  trans"\n(set_color green)"❯ "(set_color normal)'
    if set -q https_proxy; or set -q http_proxy
        set proxy -theme random -e google
    end
    while read -p $prompt line
        if string match -q '* *' -- $line
            echo "  $(command trans $proxy $line )"
        else
            kd $line
        end
    end
end
