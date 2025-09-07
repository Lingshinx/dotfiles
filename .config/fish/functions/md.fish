function md --wraps='mkdir -p'
  mkdir -p $argv
  isatty stdout
  or string join \n $argv
end
