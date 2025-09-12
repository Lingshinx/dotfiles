function push
  set -f stack (md /tmp/lingshin/$fish_pid)
  set -f stackfile $stack/.stack

  if not isatty stdin
    if test (count $argv) -gt 1 || string match -rq -- '-\d+' $argv[1]
      error -e just {one file} allowed when there is stdin
      return 1
    end

    set -f target (test -z "$argv" && mktemp --tmpdir=$stack || echo $stack/(basename -- $argv))
    cat > $target
    echo $target | tee --append $stackfile
    return
  end

  if test -z "$argv"
    mktemp --tmpdir=$stack | tee --append $stackfile
    return
  end

  set -f double_dash 0
  for file in $argv
    if test $double_dash = 0
      if test $file = --
        set double_dash 1
        continue
      else if string match -rq -- '-\d+' $file
        seq 1 (string sub --start 2 -- $file) | xargs -I {} mktemp --tmpdir=$stack
        continue
      end
    end
    set double_dash 0
    set -f target $stack/(basename -- $file)
    test -f $file && cp $file $target || echo > $target
    echo $target
  end | tee --append $stackfile
end
