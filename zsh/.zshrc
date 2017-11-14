# For tmux and friends
export TERM="xterm-256color"

#################################################################

# If antigen isn't installed, get it
if [ ! -d ~/.antigen-git/ ]; then
    git clone https://github.com/zsh-users/antigen.git ~/.antigen-git/
fi

# Load antigen
source ~/.antigen-git/antigen.zsh

# Load powerlevel9k theme
export POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/bhilburn/powerlevel9k/
antigen theme bhilburn/powerlevel9k powerlevel9k

# Default bundles
antigen bundle command-not-found

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Suggest bundle (cntrl + space to accept)
antigen bundle zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# Finish
antigen apply

################################################################

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( root_indicator status virtualenv context dir dir_writable )
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(  )

# GDB supress error messages
alias gdb="gdb -q"

# Automatically update the scripts in the background
(zsh -c "cd ~/.gbps-quick/; git pull 1>/dev/null" &) 

# Always default to python3
alias python=python3

# Adds fzf file searching
# Use Cntrl+T to fuzzy find files in the current or subdirectories
# Must install beforehand or install using vimplug :PlugInstall
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
