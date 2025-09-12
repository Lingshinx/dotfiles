function pop
  set -f stack /tmp/lingshin/$fish_pid
  set -f stackfile $stack/.stack

  if not test -f $stackfile
    error -e no stack now, use {push} first
    return 1
  end

  if test (wc -l $stackfile | choose 0) -le 0
    error -e stack underflow!
    return 1
  end

  if test -z "$argv"
    isatty stdout
      or sed -n '$'p $stackfile
    sed -i '$d' $stackfile
    return 0
  end

  if not string match -rq '^\d+$' "$argv"
    error -e give me just a {number}, plz
    return 1
  end

  set -f line (math (wc -l $stackfile | choose 0) - $argv +1)
  isatty stdout
    or tail -n $argv $stackfile | tac
  sed -i $line,'$d' $stackfile
end
