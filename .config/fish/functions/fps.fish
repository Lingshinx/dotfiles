function fps
    set filename $argv[1]
    echo $filename
    if test -z $filename
        echo set
        set filename "."
    end
    if string match --quiet 'image/*' (wl-paste -l)
        if test -d $filename
            set filename "$filename/temp.$(wl-paste -l | cut -d / -f 2)"
        end
        wl-paste >$filename
        echo "image $filename okly copied"
    else if wl-paste -l | rg --quiet --regexp '^text/uri-list$'
        cp (wl-paste) $filename
        echo "file $filename okly copied"
    else
        if test -d $filename
            set filename "$filename/temp"
        end
        wl-paste >$filename
        echo "text $filename okly copied"
    end
end
