#!/usr/bin/env -S nu -n --no-std-lib

# fcp

# Copy files to clipboard
@category filesystem
@example "copy a file to system clipboard" { fcp example.file }
@example "compress given files and copy to system clipboard" { fcp example1.file example2.file }
export def main [
  --output (-o): string # Name of Tarball, only useful when copying multiply files
  ...file: path # Files to be copied
] {
  if ($file | is-empty) {
    return (help main)
  }

  let length = ($file | length)
  let file = if $length == 1 {
    $file | first | path expand
  } else if $length > 1 {
    let tempfile = if ($output | is-not-empty) {
      (mktemp --directory)/($output)
    } else {
      mktemp --suffix .tar.gz
    }
    ^tar -czf $tempfile ...$file
    $tempfile
  }
  ^wl-copy --type text/uri-list file://($file)
}
