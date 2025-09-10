function ramdir
  set source_dir $argv[1]
  set cache_dir ~/.cache/lingshin/randoms/(realpath --relative-base=$HOME $source_dir | tr / -)
  set list_file (md $cache_dir)/list
  set index_file $cache_dir/index

  if not test -d $source_dir
    error -e "No such file or directory"
    return 1
  end

  set index (math 0 + (cat "$index_file" 2>/dev/null || echo 0))

  if test $index -le 0
    set list "$(fd . $source_dir --type file)"
    if test -z "$list"
      error "this directory is empty"
      return 1
    end

    echo $list | shuf >$list_file
    wc -l <$list_file >$index_file
  end

  set index (cat $index_file)

  sed -n "$index"p $list_file
  math $index - 1 >"$index_file"
end
