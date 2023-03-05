#--------------------------------------------------------------------------
# Oh My Zsh
#--------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export CLICOLOR=1
export TERM=xterm-256color
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

ZSH_THEME="unicorn"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    composer
    docker
    docker-compose
    git
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias cat="bat"
alias dsp="yes | docker system prune"
alias dvp="yes | docker volume prune"
