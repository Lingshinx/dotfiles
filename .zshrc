zsh_home=~/.zsh

source $zsh_home/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle z
antigen bundle sudo
antigen bundle fzf
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

source $zsh_home/alias.sh
source $zsh_home/env.sh
source $zsh_home/keybind.sh
source $zsh_home/function.sh

eval "$(starship init zsh)"
