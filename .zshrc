source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "themes/steeef", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", nice:-10

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# History settings
export HISTFILE=~/.zhistory
export SAVEHIST=100000
export HISTSIZE=100000

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Highlights the suggestions created by tab, eg; from `ls`
zstyle ':completion:*' menu select
# Supposed to highlight the substring in the suggestion list from `ls`
export ZLS_COLORS=$LS_COLORS

zplug load --verbose

# Fasd keeps a record of use paths so you can quickly get to them
eval "$(fasd --init auto)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Bind UP/DOWN to search through history
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

alias 'gs'='git status'
alias 'o'='xdg-open'
alias 'j'='fasd_cd -d'
alias 'e'='nvim'
alias 'la'='ls -alh'
alias 'ht'='hiptext -font /usr/share/fonts/TTF/DejaVuSansMono.ttf -xterm256unicode -fast'
export GOPATH=~/.go
export GOBIN=~/.go/bin
export PATH=$PATH:$GOBIN

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

