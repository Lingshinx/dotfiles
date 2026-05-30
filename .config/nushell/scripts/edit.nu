# Edit files from various sources
export def main [] {}

def editor [] {
  $env.VISUAL? | default $env.EDITOR? | default $env.config.buffer_editor | if ($in | is-not-empty) {
    $in
  } else {
    for cmd in [n] {
      if (which $cmd | is-not-empty) { return $cmd }
    }
  }
}

# Just Edit Files using the default editor
@example "edit files" { edit file foo bar }
export def file [
  ...files: path # paths of files to edit
] {
  ignore | ^(editor) ...$files
}

# Edit stdin and ouput the edited text
@example "edit input from extern ls" { ^ls | edit stdin } --result "Music"
export def stdin [
]: any -> string {
  let temp = (mktemp)
  $in | save --force $temp
  file $temp
  open $temp
}

def cmds [] {
  ls ~/.local/bin | get name | path basename | append (scope commands | where type == custom).name
}

# Edit executable scripts
@example "edit custom script" { edit cmd foo }
export def cmd [
  ...cmd: string@cmds # script name
] {
  $cmd
  | each {|it| which $it | get -o 0.path }
  | each { path expand }
  | where {|it| (^file -b --mime-encoding $it) != "binary" }
  | file ...$in
}

# Edit desktop entries
@example "edit element desktop entry" { edit app Element }
export def app [
  --regex (-r) # use regex to search desktop entries
  --all (-a) # edit all desktop entries instead first found
  pattern: any
] {
  ls ~/.local/share/applications/*.desktop /usr/share/applications/*.desktop 
  | get name
  | where {|it|
    open $it
    | lines
    | where $it =~ "^Name="
    | str replace --regex '^Name=' ''
    | any {|it| if ($pattern | describe ) == "closure" { do $pattern $it } else if $regex { $it =~ $pattern } else { $it == $pattern }}
  } | let desktops
  if ($desktops | is-not-empty) {
    if $all {
      file ...$desktops
    } else {
      file ($desktops | first)
    }
  }
}
