  export def --env --wrapped main [
    name_or_url?: string@__try_rs_complete
    ...args
] {
    let all_args = (if $name_or_url == null { [] } else { [$name_or_url] } | append $args)

    # Pass flags/options directly to stdout without capturing
    if ($all_args | any { |arg| $arg | str starts-with '-' }) {
        ^try-rs ...$all_args
        return
    }

    # Capture output. Stderr (TUI) goes directly to terminal.
    let output = (^try-rs ...$all_args | str trim)

    if ($output | is-not-empty) {
        if ($output | str starts-with "cd ") {
            # Grabs the path out of stdout returned by the binary and removes the single quotes
            let path = ($output | str replace --regex '^cd ' '' | str replace --all "'" "" | str replace --all '"' "")
            if ($path | path exists) {
                cd $path
            }
        } else {
            # If it's not a cd command, it's likely an editor command
            nu -c $output
        }
    }
}

# try-rs tab completion for directory names
# Add this to your Nushell config or env file

def __try_rs_get_tries_paths [] {
    # Check TRY_PATH environment variable first
    if ($env.TRY_PATH? | is-not-empty) {
        return ($env.TRY_PATH | split row "," | each { |s| $s | str trim })
    }
    
    # Try to read from config file
    let config_paths = [
        ($env.HOME | path join ".config" "try-rs" "config.toml"),
        ($env.HOME | path join ".try-rs" "config.toml")
    ]
    
    for config_path in $config_paths {
        if ($config_path | path exists) {
            let content = (open $config_path | str trim)
            # Try tries_path (supports single or multiple paths with comma)
            if ($content =~ 'tries_path\\s*=\\s*"?([^"]+)"?') {
                let path = ($content | parse -r 'tries_path\\s*=\\s*"?([^"]+)"?' | get capture0.0? | default "")
                if ($path | is-not-empty) {
                    # Check if contains comma (multiple paths)
                    if ($path | str contains ",") {
                        return ($path | split row "," | each { |s| ($s | str trim | str replace "~" $env.HOME) })
                    else
                        return ([($path | str replace "~" $env.HOME)])
                    }
                }
            }
        }
    }
    
    # Default path
    [($env.HOME | path join "work" "tries")]
}

def __try_rs_complete [context: string] {
    let tries_paths = (__try_rs_get_tries_paths)
    
    mut all_dirs = []
    for tries_path in $tries_paths {
        if ($tries_path | path exists) {
            let dirs = (ls $tries_path | where type == "dir" | get name | path basename)
            $all_dirs = ($all_dirs | append $dirs)
        }
    }
    $all_dirs
}
