autoload -U colors && colors
export PATH=$(go env GOPATH)/bin:$PATH
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '%F{red}('$branch')%F{reset} '
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

export TERM=xterm-256color
export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
prompt='%1~ $(git_branch_name)$ '

alias ls="gls --color -h --group-directories-first"
alias vim="nvim"
alias icat="kitty +kitten icat"
alias theme="kitty +kitten themes"
alias ranger="TERM=xterm-kitty ranger"
alias pubip="curl icanhazip.com"
alias k="kubectl"

# auto/tab completion
autoload -U compinit; compinit
_comp_options+=(globdots)
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
bindkey -M menuselect '^[[Z' reverse-menu-complete
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

tabs -4
