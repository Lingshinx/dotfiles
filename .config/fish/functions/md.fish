function md --wraps='mkdir -p'
  mkdir -p $argv
  if not isatty stdout
    string join \n $argv
  end
end
