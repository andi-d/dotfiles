# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/andi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export XDG_CONFIG_HOME="$HOME/.config"

source ~/dotfiles/zsh/aliases.zsh

export NVM_DIR="$HOME/.config/nvm"
export EDITOR="nvim"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

command_exists() {
  command -v "$1" &>/dev/null
}

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

