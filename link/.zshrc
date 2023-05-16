#!/bin/sh

source $DOTFILES_PATH/zsh/oh-my-zsh.sh
source $DOTFILES_PATH/zsh/alias.sh

for i in $(find . -name env.sh);
do;
    source $i
done;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
