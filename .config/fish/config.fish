if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source
    direnv hook fish | source
end
