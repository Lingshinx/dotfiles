function fcp
    wl-copy --type text/uri-list "file://$(realpath $argv[1])"
end
