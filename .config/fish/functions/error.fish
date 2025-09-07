function error
  argparse 'e/error' -- $argv
  or return
  begin
    set_color -o red
    if test -n "$_flag_error"
      echo -n '[ERROR] '
    end
    echo $argv | sed 's/{{/__lingshin__/g;s/}}/__nihsgnil__/g;s/{/\x1b[33m/g;s/}/\x1b[31;1m/g;s/__lingshin__/{/g;s/__nihsgnil__/}/g'
    set_color normal
  end > /dev/stderr
end
