#!/bin/fish

set tmp (md /tmp/lingshin)/xight
set cache (md ~/.cache/lingshin)/xight
set dir ~/.config/lingshin/xight

set mode (cat $tmp) # no use of cmd `default` at the first time for short-circut

test -z "$mode"
and set mode (default light < $cache)

fd . $dir/$mode -x {}

test "$mode" = light && echo night || echo light | tee $tmp > $cache
