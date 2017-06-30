# curl -sL zplug.sh/installer | zsh
source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "plugins/colorize", from:oh-my-zsh
zplug "joel-porquet/zsh-dircolors-solarized"
zplug "plugins/git", from:oh-my-zsh
zplug "tombh/zsh-git-prompt", as:plugin, use:zshrc.sh
zplug "oz/safe-paste"
zplug "jreese/zsh-titles"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting", defer:3
# cd into most frequently/recently used paths
zplug "rupa/z", as:plugin, use:z.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# @args: red, gree, blue, string
function print_true_rgb() {
  fg_open="\033[38;2;"
  bg_open="\033[48;2;"
  close="m$4\033[0m"
  print "$fg_open$1;$2;$3$close"
}

PROMPT='
$(print_true_rgb 203 75 22 "%n")@$(print_true_rgb 42 161 152 "%m") $(print_true_rgb 133 153 0 "%~%b") $(git_super_status)
$(print_true_rgb 32 147 209 " ") '

# History settings
export HISTFILE=~/.zhistory
export SAVEHIST=100000
export HISTSIZE=100000
setopt BANG_HIST # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a line previously found.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.
setopt HIST_BEEP # Beep when accessing nonexistent history.

# Colours come from this plugin: joel-porquet/zsh-dircolors-solarized
export ZLS_COLORS=$LS_COLORS

# Highlights the suggestions created by tab, eg; from `ls`
zstyle ':completion:*' menu select
# Highlight the substring in the suggestion list from `ls`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# I just did this to get approximate (fuzzy) completion, where it tries to complete
# things that are typed incorrectly.
# _expand expands variables
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# Expand *all* variables
zstyle ':completion:*:expand:*' tag-order all-expansions

# Helpful completion feedback
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Just type the name of a cd'able location and press return to get there
setopt auto_cd

# Ensure Home/End do what their meant to
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Bind UP/DOWN to search through history
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

alias 'gs'='git status'
alias 'o'='xdg-open'
alias 'e'='nvim'
alias 'ls'='ls --color'
alias 'la'='ls -alh'
alias 'less'='less -r'
alias 'ht'='hiptext -font /usr/share/fonts/TTF/DejaVuSansMono.ttf -xterm256unicode -fast'

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export GOPATH=~/.go
export GOBIN=~/.go/bin
export PATH=$PATH:$GOBIN

source $HOME/.cargo/env

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
PATH=$PATH:./node_modules/.bin:$HOME/.config/yarn/global/node_modules/.bin

