# Initialize hook to add new entries to the database.
export-env {
  $env.config = (
    $env.config?
    | default {}
    | upsert hooks { default {} }
    | upsert hooks.env_change { default {} }
    | upsert hooks.env_change.PWD { default [] }
  )
  if ($env.config.hooks.env_change.PWD | is-empty) or (
      $env.config.hooks.env_change.PWD | any { get __zoxide_hook | is-not-empty  }
  ) {
    $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {
      __zoxide_hook: true,
      code: {|_, dir| ^zoxide add -- $dir}
    })
  }
}

alias __cd = cd

# Jump to a directory using interactive search.
export def --env --wrapped zi [...rest:string] {
  __cd $'(^zoxide query --interactive -- ...$rest | str trim -r -c "\n")'
}

def "nu-complete zoxide path" [context: string] {
  let parts = $context | split words | skip 1 | each { str downcase }
  let completions = (
    ^zoxide query --list --exclude $env.PWD -- ...$parts
    | lines
    | each { |dir|
      if ($parts | length) <= 1 {
        $dir
      } else {
        let dir_lower = $dir | str downcase
        let rem_start = $parts | drop 1 | reduce --fold 0 { |part, rem_start|
          ($dir_lower | str index-of --range $rem_start.. $part) + ($part | str length)
        }
        {
          value: ($dir | str substring $rem_start..),
          description: $dir
        }
      }
    })
  {
    options: {
      sort: false,
      completion_algorithm: substring,
      case_sensitive: false,
    },
    completions: $completions,
  }
}

# Jump to a directory using only keywords.
export def --env --wrapped z [...rest: string] {
  let path = match $rest {
    [] => {'~'},
    [ '-' ] => {'-'},
    [ $arg ] if ($arg | path expand | path type) == 'dir' => {$arg}
    _ => {
      ^zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n"
    }
  }
  __cd $path
}

export alias cd = z
