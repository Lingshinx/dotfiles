#!/usr/bin/env -S nu -n --no-std-lib

# A kit of commands to record watch process and play with prefered players
#
# You must use one of the following subcommands. Using this command as-is will only produce this help message.
@category media
@search-terms play video
export def main [] {}

def err [param] { error make --unspanned $param }

def series-names [context:string] {
  if (["--dir" "-d"] | any {|it| $context | str contains $it }) { return }
  let completions = do {
    with-data --dir "" {|id_map series|
      let series = $series
      | each {
        let description = format-process
        $in
        | insert description $description
        | insert watched ($description | split row "/" | $in.0 == $in.1 )
        | rename --column { name: value }
      }

      let id_map = $id_map
      | transpose value index
      | where {|it| $series | get $it.index | $in.value != $it.value }
      | insert watched {|it| $series | get $it.index | get watched }

      $series
      | append $id_map
      | sort-by -c {|a b|
        if ($a.watched != $b.watched) {
          $b.watched
        } else {
          $a.index < $b.index
        }
      }
      | insert style {|it|
        {
          attr: (if ($it.description? | is-not-empty) { "bold" })
          fg: (if $it.watched { "green" } else { "blue" })
        }
      }
      | select value description? style watched
    }
  }
  {
    completions: $completions
    options: {
      case_sensitive: false,
      completion_algorithm: substring,
      sort: false,
    },
  }
}

def config []: nothing -> record {
  let xdg_config = $env.XDG_CONFIG_HOME? | default ($env.HOME)/.config
  let video_path = try {
    sh -c $'source ($xdg_config)/user-dirs.dirs; echo $XDG_VIDEOS_DIR' e> /dev/null
  } catch {
    $env.HOME
  }
  let default_config = {
    dir: $video_path
    player: mpv
    players: { mpv: "mpv" sync: "syncplay" ff: "ffplay" }
  }
  let config_path = ($xdg_config)/bapt/config.json
  if ($config_path | path exists) {
    $default_config | merge deep (open $config_path)
  } else {
    $default_config
  }
}

const bapt_file_name = ".bapt.json"

def bapt-file []: directory -> path {
  path join $bapt_file_name
}

# The directory where the processes are recorded depending on the current directory
export def dir []: nothing -> string {
  if ($bapt_file_name | path exists) { pwd } else { config | get dir }
}

def "data read" [dir: directory]: nothing -> record {
  const spec = { id_map: {} series: [] }
  try { $spec | merge (open ($dir | bapt-file)) } catch { $spec }
}

def "data save" [dir: directory]: record -> nothing {
  to json | save --force ($dir | bapt-file)
}

def series-id [series_name: string]: record -> int {
  $in | get id_map | get --optional $series_name | default -- -1
}

def series [series: string@series-names]: record -> record {
  let data
  let index = $data | series-id $series
  if $index < 0 { err $"series \"($series)\" doesn't exist" }
  $data.series | get $index
}

def with-data [
  --save
  --dir dir: directory
  process: closure
] {
  let dir = $dir | default --empty (dir)
  data read $dir
  | do $process $in.id_map $in.series
  | if $save { data save $dir } else { $in }
}

def with-series [
  --save
  --dir dir: directory
  series: string@series-names
  process: closure
] {
  if ($series | is-empty) { err "use --series (-s) to specify which to watch" }
  with-data --save=($save) --dir $dir {
    let data
    let series = $data | series $series
    | default { err $"series \"($series)\" doesn't exist" }
    if $save {
      $data | upsert series { upsert $series.index $process }
    } else {
      $series | do $process $in
    }
  }
}

# Increase the current episode count
@example "Increace the episode count of \"avatar\"" { bapt inc avatar }
export def inc [
  --dir (-d): directory = "" # Set path of recorded data
  series: string@series-names # Series whose count is to increase
] {
  with-series --save --dir $dir $series {
    upsert count { $in + 1 }
  }
}

# Config series specified
@example "Set the pattern of \"kaminabotan\"" { bapt set --pattern "- (?<episode>\\d+) " kaminabotan }
export def set [
  --dir (-d): directory = "" # Set path of recorded data
  --count (-c): int # Set episode count
  --pattern (-p): string # Set pattern to match the episode
  series: string@series-names # Series to set
] {
  with-series --save --dir $dir $series {
    merge ({count: $count pattern: $pattern} | compact)
  }
}

# Reset the episode count
@example "Reset the count of \"lara\"" { bapt reset lara }
export def reset [
  --dir (-d): directory = "" # Set path of recorded data
  series: string@series-names # Series whose count is to be reset
] {
  with-series --save --dir $dir $series {
    upsert count 1
  }
}

def episode [pattern: string]: string -> int {
    parse --regex $pattern
    | get --optional 0.episode
    | default { 0 }
    | into int
}

def get-episode [count: int]: record -> string {
  match $in {
    { $pattern $path } => {
      ls $path | where ($it.name | episode $pattern) == $count
    }
  } | get --optional 0.name
}

def current []: record -> string {
  get-episode $in.count
}

# Query the process
@example "Query the current episode of \"akujo\"" { bapt query akujo } --result "Futsutsuka-na-Akujo/Futsutsuka na Akujo dewa Gozaimasu ga - 07 [WebRip 1080p HEVC-10bit AAC ASSx2].mkv"
export def query [
  --dir (-d): directory = ""       # Set path of recorded data
  series: string@series-names # Series name to query
]: nothing -> string {
  with-series --dir $dir $series { current }
}

# Register a new series
@example "Register a series located in `./Avatar`" { bapt register ./Avatar }
@example 'Register a series named `sakeyuri` and with pattern of `" - (?<episode\\d+)"`' { bapt register ./kaminabotan --series sakeyuri }
export def register [
  --dir (-d): directory = ""    # Set path of recorded data
  --series (-s): string         # Series name, default to ($path | path basename)
  --pattern (-p): string        # Pattern to match episode
  --count (-c): int             # Initial episode count
  --force (-f)                  # Remove existing name
  path: string
] {
  if not ($path | path exists) { err $"path \"($path)\" does not exist" }
  let series = if ($series | is-empty) { $path | path basename }
  with-data --save --dir $dir {|id_map|
    let data
    let index = $data | series-id $series
    let index = if $index != -1 {
      if not $force { err "series already exists" }
      if ($data.series | get --optional $index | is-not-empty) {
        $index
      }
    } | default { $data.series | length }
    let id_map = $id_map | upsert $series $index
    let series = $data.series | upsert $index {
      name: $series
      count: ($count | default 1)
      pattern: ($pattern | default '[^\d](?<episode>\d{2})[^\d]')
      index: $index
      path: ($path | path expand)
    }
    {
      id_map: $id_map
      series: $series
    }
  }
}

def format-episode [width: int = 2]: int -> string  {
  fill --alignment right --character '0' --width $width
}

# Get the names of series
export def names [
  --dir (-d): directory = ""  # Set path of recorded data
  series: string@series-names # Sereis whose name to be checked
] {
  with-data --dir $dir {|id_map|
    let index = $id_map
    | get $series
    | default { err $"series \"($series)\" wasn't registered" }
    $id_map
    | transpose key value
    | where value == $index
    | get key
  }
}

def format-process []: record -> string {
  let $series
  let max = ls $series.path
  | get name
  | each { episode $series.pattern }
  | math max
  $"($series.count | format-episode)/($max | format-episode)"
}

def format-series []: [
  record -> record
  table -> table
] {
  update pattern {|it| $it | format-process }
  | update path { path basename }
  | rename --column { pattern: process }
}

# Show the status of series (if not series specified, show all)
@example "Show the status of 'yakuya'" { bapt status yakuya }
@example "Show the status of all series" { bapt status }
export def status [
  --dir (-d): directory = ""   # Set path of recorded data
  series?: string@series-names # Series whose status to be checked
]: nothing -> record {
  if ($series | is-empty) {
    with-data --dir $dir { get series | format-series }
  } else {
    with-series --dir $dir $series { format-series }
  }
  | reject index count path
}

# Give alias to a series
@example "Give aliases to \"yakuya no hitorigoto\"" { bapt add-name "yakuya no hitorigoto" yakuya maomao }
export def add-name [
  --dir (-d): directory = ""  # Set path of recorded data
  --force (-f)                # Remove existing alias
  series: string@series-names # Series to be given alias
  ...names: string            # Aliases
] {
  with-data --save --dir $dir {|id_map|
    let data
    if not $force {
      for name in $names {
        if (
          $id_map
          | get --optional $name
          | is-not-empty
        ) {
          err $"name \"($name)\" already registered"
        }
      }
    }
    let index = $data | series-id $series
    if $index == -1 { err $"sereis \"($series)\" doesn't exist" }
    let $id_map = $id_map | merge ($names | each { [$in $index] } | into record)
    $data | upsert id_map $id_map
  }
}

def players [] { (config).players | columns }

# Play the series's current or specified episode
export def play [
  --dir (-d): directory = ""    # Set path of recorded data
  --player (-p): string@players # Player to play
  --count (-c): int             # specify the episode, default to the current
  --inc (-i)                    # increase to count after playing
  series: string@series-names
] {
  with-series --dir $dir $series --save=$inc {
    let series
    let current = $series | if ($count | is-empty) {
      current
    } else {
      get-episode $count
    }
    let config = config
    let player = $player | default { $config.player }
    let cmd = $config.players | get --optional $player
    let cmd = if ($cmd | describe --detailed).type == "list" {
      $cmd
    } else {
      $cmd | split row " "
    }
    job spawn { run-external $cmd.0 ...($cmd | skip 1) $current }
    if $inc { $series | update count { $in + 1 } }
  }
}
