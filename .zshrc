autoload -U colors && colors

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' ('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#export PS1="➜ %1~ $(git_branch_name) $ " 
prompt='➜ %1~%{$fg[red]%}$(git_branch_name) $reset_color%}$ '

alias ls="gls --color -h --group-directories-first"
alias vim="nvim"
alias icat="kitty +kitten icat"
alias theme="kitty +kitten themes"
alias ranger="TERM=xterm-kitty ranger"
alias math="calc"
alias idea="open -na 'IntelliJ IDEA CE.app' ."
alias kat="kitty -1 -d=."
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
#.... privip     ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }',  This only works in a shell script for some reason, moved it to /usr/local/bin/privip

# auto/tab completion
autoload -U compinit; compinit
_comp_options+=(globdots)
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
