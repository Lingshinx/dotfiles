function md --wraps='mkdir -p'
  set path $argv[1]
  mkdir -p $path
  if not isatty stdout
    echo $path
  end
end
