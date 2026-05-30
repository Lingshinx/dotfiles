function try-rs
    # Pass flags/options directly to stdout without capturing
    for arg in $argv
        if string match -q -- '-*' $arg
            command try-rs $argv
            return
        end
    end

    # Captures the output of the binary (stdout) which is the "cd" command
    # The TUI is rendered on stderr, so it doesn't interfere.
    set command (command try-rs $argv | string collect)
    set command_status $status

    if test $command_status -eq 0; and test -n "$command"
        eval $command
    end
end

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


# try-rs tab completion for directory names
function __try_rs_get_tries_path
    # Check TRY_PATH environment variable first
    if set -q TRY_PATH
        # Check if contains comma
        if echo "$TRY_PATH" | command grep -q ","
            for path in (string split "," $TRY_PATH)
                printf '%s\n' (string trim $path)
            end
        else
            printf '%s\n' $TRY_PATH
        end
        return
    end
    
    # Try to read from config file
    set -l config_paths "$HOME/.config/try-rs/config.toml" "$HOME/.try-rs/config.toml"
    for config_path in $config_paths
        if test -f $config_path
            # Try tries_path (supports single or multiple paths with comma)
            set -l tries_path (command grep -E '^\s*tries_path\s*=' $config_path 2>/dev/null | command sed -E 's/.*=[[:space:]]*"?([^"]*)"?.*/\1/' | command sed "s|~|$HOME|" | string trim)
            if test -n "$tries_path"
                # Check if it contains comma (multiple paths)
                if echo "$tries_path" | command grep -q ","
                    for path in (string split "," $tries_path)
                        printf '%s\n' (string trim $path)
                    end
                else
                    printf '%s\n' $tries_path
                end
                return
            end
        end
    end
    
    # Default path
    printf '%s\n' "$HOME/work/tries"
end

function __try_rs_complete_directories
    for tries_path in (__try_rs_get_tries_path)
        if test -d $tries_path
            command ls -1 $tries_path 2>/dev/null | while read -l dir
                if test -d "$tries_path/$dir"
                    echo $dir
                end
            end
        end
    end
end

complete -f -c try-rs -n '__fish_use_subcommand' -a '(__try_rs_complete_directories)' -d 'Try directory'
