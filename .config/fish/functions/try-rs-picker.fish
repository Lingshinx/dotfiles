function try-rs-picker
    set -l picker_args --inline-picker

    if set -q TRY_RS_PICKER_HEIGHT
        if string match -qr '^[0-9]+$' -- "$TRY_RS_PICKER_HEIGHT"
            set picker_args $picker_args --inline-height $TRY_RS_PICKER_HEIGHT
        end
    end

    if status --is-interactive
        printf "\n"
    end

    set command (command try-rs $picker_args | string collect)
    set command_status $status

    if test $command_status -eq 0; and test -n "$command"
        eval $command
    end

    if status --is-interactive
        printf "\033[A"
        commandline -f repaint
    end
end
