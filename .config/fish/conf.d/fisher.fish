set fisher_path ~/.local/share/fisher

set -a fish_complete_path $fisher_path/completions
set -a fish_function_path $fisher_path/functions

if not type -q fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

for file in $fisher_path/conf.d/*.fish
  source $file
end
