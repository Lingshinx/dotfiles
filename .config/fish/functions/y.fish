function y
    yazi $argv --cwd-file=(push)
    read -z cwd <(top) 
      and test $cwd != $PWD
      and builtin cd -- $cwd
    pop
end
