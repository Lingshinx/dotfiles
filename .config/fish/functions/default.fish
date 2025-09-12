function default
  if not isatty stdin
    read -f stdin
    echo $stdin | wc -w | read -f is_empty
    test $is_empty -gt 0
    and echo $stdin
    or echo $argv
    return 0
  end

  set -f rest $argv[2..]
  test -n "$rest"
  and echo $rest
  or echo $argv[1]
end
