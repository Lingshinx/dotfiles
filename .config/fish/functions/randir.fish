function randir
  argparse 'c/current' 'i/index' -- $argv
  or return 1
  set -f source_dir $argv[1]
  set -f cache_dir ~/.cache/lingshin/randoms/(realpath --relative-base=$HOME $source_dir | tr / -)
  set -f list_file (md $cache_dir)/list
  set -f index_file $cache_dir/index

  if not test -d $source_dir
    error -e "No such file or directory"
    return 1
  end

  set -f index (math 0 + (cat "$index_file" 2>/dev/null || echo 0))

  if set -q _flag_index
    echo $index
    return 0
  end

  if test $index -le 0
    set -f list "$(fd . $source_dir --type file)"
    if test -z "$list"
      error "this directory is empty"
      return 1
    end

    echo $list | shuf >$list_file
    set -f index (wc -l <$list_file)
  end

  set -q _flag_current
  and set -f index (math $index + 1)
  or math $index - 1 >"$index_file"

  sed -n "$index"p $list_file
end
