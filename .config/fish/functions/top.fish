function top
  set -f stack /tmp/lingshin/$fish_pid
  set -f stackfile $stack/.stack
  if not test -f $stackfile
    error -e no stack now, use {push} first
    return 1
  end

  if test -z "$argv"
    sed -n '$p' $stackfile
    return
  end

  set -f double_dash 0
  for file in $argv
    if test $double_dash = 0
      test $file = --
      and set double_dash 1
      and continue

      string match -r -- '-(\d*)(,?)(\d*)' $file | read --line -f all start comma end
      if test -n "$all"
        if test -z "$start"
          set start 1
        else if test -z "$comma"
          sed -n (math (wc -l $stackfile | choose 0) +1 -$start)p $stackfile
          return
        end
        set end (default '$' $end)
        tac $stackfile | sed -n "$start,$end"p
        continue
      end
    end

    set double_dash 0
    test -f $stack/$file && echo $stack/$file
  end
end
