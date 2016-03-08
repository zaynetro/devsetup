# Common bash environment

# Nvm
if [[ -d $HOME/.nvm ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# Go PATH
if [[ -d $HOME/Code/go ]]; then
  export GOPATH="$HOME/Code/go"
  export PATH=$PATH:$GOPATH/bin
fi

# Cargo
if [[ -d $HOME/.cargo ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# Stack
if [[ -d $HOME/.local ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Default editor
export EDITOR='vim'

# Show colors in the terminal
force_color_prompt=yes
if [[ "$TERM" == "xterm" ]]; then
  export TERM=xterm-256color
fi

# Aliases
alias tmux='tmux -2'

# Case insensitive completion
bind "set completion-ignore-case on"

# Ignore dublicate commands in bash history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
# append to history, don't overwrite it
shopt -s histappend
#Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
# Useful timestamp format
HISTTIMEFORMAT='%F %T '

# Git aware prompt
export GITAWAREPROMPT=$HOME/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# Custom bash prompt
export PS1="\n\u@\h:\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\n\$ "

# OS specific environment
case $OSTYPE in
  "darwin"*)
    source "$HOME/.bash/osx.sh"
    ;;
  "linux-gnu")
    source "$HOME/.bash/linux.sh"
    ;;
esac
