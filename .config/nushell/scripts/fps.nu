#!/usr/bin/env -S nu -n --no-std-lib

# fps

const gnome = "x-special/gnome-copied-files"

# Paste file from clipboard
@category filesystem
@example "paste a file from system clipboard" { fps paste.png }
@search-terms clipboard paste file
export def main [
  file_name: path = "." # Destination file name or directory
] {
  let mime_types = (^wl-paste -l | lines)
  if ($mime_types | any { $in == 'text/uri-list' }) {
    ^wl-paste -nt text/uri-list
    | lines -s
    | each { url parse | get path }
    | let file_list
    let is_move = ($mime_types | any { $in == $gnome })
      and copy == (wl-paste -t $gnome | lines | first)
    if $is_move {
      mv ...$file_list $file_name
    } else {
      cp ...$file_list $file_name
    }
  } else {
    let file_name = if ($file_name | path type) == dir {
      let ext = $mime_types | parse "image/{ext}" | get ext.0? | default txt
      $"tmp.($ext)"
    } else {
      $file_name
    }
    ^wl-paste o> $file_name
  }
}
