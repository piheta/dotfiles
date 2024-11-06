autoload -U colors && colors
export PATH=$(go env GOPATH)/bin:$PATH
eval "$(zoxide init --cmd cd zsh)"
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

###
### SETUP PROMPT
###
setopt prompt_subst
export TERM=xterm-256color
export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
prompt='%1~ $(git_branch_name)$ '
tabs -4


###
### ALIASES
###
alias ls="gls --color -h --group-directories-first"
alias icat="kitty +kitten icat"
alias theme="kitty +kitten themes"
alias ranger="TERM=xterm-kitty ranger"
alias pubip="curl icanhazip.com"
alias k="kubectl"


nvim() {
    # Set Kitty padding to zero when Neovim starts
    kitty @ set-spacing padding=0
    
    # Open Neovim with any arguments passed
    command nvim "$@"
    
    # Restore Kitty padding to default when Neovim exits
    kitty @ set-spacing padding=default
}
alias vim="nvim"




###
### INIT TAB COMPLETION
###
{
  # load compinit and rebind ^I (tab) to expand-or-complete, then compile
  # completions as bytecode if needed.
  lazyload-compinit() {
    zmodload -i zsh/complist
    autoload -Uz compinit
    zstyle ':completion:*' menu select
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    bindkey -M menuselect '^[[Z' reverse-menu-complete
    # compinit will automatically cache completions to ~/.zcompdump
    compinit
    bindkey "^I" expand-or-complete
    {
      zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
      # if zcompdump file exists, and we don't have a compiled version or the
      # dump file is newer than the compiled file, update the bytecode.
      if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
      fi
    } &!
    # pretend we called this directly, instead of the lazy loader
    zle expand-or-complete
  }
  # mark the function as a zle widget
  zle -N lazyload-compinit
  bindkey "^I" lazyload-compinit
}



source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
