function trans
  set -fx trans_argu -brief -e (
    set -q https_proxy || set -q http_proxy && echo google || echo bing
  )

  if not isatty stdin
    while read -f line
      test -n "$line"
      and command trans $trans_argu "$line"
      or echo
    end
    return
  end

  if not isatty stdout
    if test -n "$argv"
      command trans $trans_argu "$argv"
      return
    else
      error -e Give me argus please
      return 1
    end
  end

  set -a trans_argu -theme random

  function translate
    if string match -q '* *' -- $argv[1]
      echo -n "  "
      command trans $trans_argu $argv[1]
    else if test -n "$argv[1]"
      kd $argv[1]
    end
  end

  set -f prompt 'echo -n \n(set_color bryellow)"  trans"\n(set_color green)"❯ "(set_color normal)'
  if test -n "$argv"
    translate "$argv"
  else
    while read -fp $prompt line
      translate $line
    end
  end

  functions --erase translate
end
