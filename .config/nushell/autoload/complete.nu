let commands_completed_by_fish = [nu git niri tailscale]

let carapace_completer = {|spans|
    CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

let fish_completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
      let value = $row.value
      let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
      if ($need_quote and ($value | path exists)) {
        let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
        $'"($expanded_path | str replace --all "\"" "\\\"")"'
      } else {$value}
    }
}

# This completer will use carapace by default
let external_completer = {|spans|
  if ($spans.0 in $commands_completed_by_fish) {
    $fish_completer
  } else {
    $carapace_completer
  } | do $in $spans
}

$env.config.completions.algorithm = "substring"
$env.config.completions.external.enable = true
$env.config.completions.external.completer = $external_completer
