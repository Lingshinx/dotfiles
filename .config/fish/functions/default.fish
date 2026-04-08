function default
  if not isatty stdin
    read -f stdin
    if test -n (string trim $stdin)
      echo $stdin
      return 0
    end
  end

  for val in $argv
    if test -n "$val"
      echo $val
      return 0
    end
  end

  return 1
end
