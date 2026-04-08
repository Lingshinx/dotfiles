function git-repo
  test -n "$GIT_USER"
  and set -fx user $GITUSER
  or set -fx user git

  function sudogit
    sudo -u $user git $argv
  end

  function git-at
    sudogit -C $argv
  end

  function repo-ls
    fd HEAD ~git --type file -X dirname | while read repo
      test (git-at $repo rev-parse --is-bare-repository) = true
      or break

      if test $argv[2] = -l
        setterm --foreground yellow
        basename $repo
        git-at $repo branch
        echo
      else
        basename $repo
      end
    end
  end

  switch $argv[1]
    case create
      sudogit init --bare ~git/$argv[2..]
    case config
      sudogit config --global $argv[2..]
    case ls
      repo-ls $argv[2]
    case '*'
      git-at $argv
  end

  functions --erase repo-ls
  functions --erase git-at
  functions --erase sudogit
end
