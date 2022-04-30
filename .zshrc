# zmodload zsh/zprof

zstyle ':zim:zmodule' use 'degit'
ZIM_HOME=~/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

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

# List colours
eval `dircolors ~/.zplug/repos/seebi/dircolors-solarized/dircolors.ansi-dark`
export ZLS_COLORS=$LS_COLORS
# Highlights the suggestions created by tab, eg; from `ls`
zstyle ':completion:*' menu select
# Highlight the substring in the suggestion list from `ls`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# _ approximate (fuzzy) completion tries to complete things that are typed incorrectly.
# _expand expands variables.
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

# Include hidden files in completions
setopt globdots

# Just type the name of a cd'able location and press return to get there
setopt auto_cd

# Ensure Home/End do what their meant to
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# CTRL+ARROW to move by words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# CTRL+BACKSPACE deletes whole word
bindkey "^H" backward-delete-word

# Bind UP/DOWN to search through history
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

# Aliases
alias 's'='sudo -E '
alias 'se'='sudoedit'
alias 'p'='pacman'
alias 'yS'='yay -S'
alias 'yR'='yay -Rsc'
alias 'gs'='git status'
alias 'o'='xdg-open'
alias 'e'='nvim'
alias 'l'='exa --long --tree --level=2 --git --all'
alias 'la'='exa --long --git --all'
alias 'ls'='exa --grid'
alias 'less'='less -r'
alias ff='fd . -type f -name'
alias be='bundle exec'
alias kc='kubectl'

alias urldecode='python -c "import sys, urllib.parse as ul; \
  print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python -c "import sys, urllib.parse as ul; \
  print(ul.quote_plus(sys.argv[1]))"'

bindkey -s '^[ ' 'xstarter\n'

# Pressing SPACE after alias expands it
function expand-alias() {
    zle _expand_alias
    zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

export SKIM_DEFAULT_COMMAND="fd --hidden --exclude 'cache' --exclude '.git' . $HOME"
export SKIM_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export SKIM_CTRL_T_OPTS="--preview='head -n10 {}'"
export SKIM_ALT_C_COMMAND="fd --hidden --exclude '*cache*' --exclude '.git' -t d . $HOME"
export SKIM_ALT_C_OPTS="--preview='exa --tree --level=2 --colour=always {}'"

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

eval `ssh-agent` >/dev/null

# Git dotfiles
# To setup on a new system:
# git clone --bare https://github.com/tombh/dotfiles $HOME/Software/dotfiles
# dotfiles checkout
# dotfiles config status.showUntrackedFiles no
alias dotfiles='/usr/bin/git --git-dir=$HOME/Software/dotfiles/ --work-tree=$HOME'

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
which rbenv >/dev/null && eval "$(rbenv init -)"

# Python poetry
[ -f $HOME/.poetry/env ] && source $HOME/.poetry/env

# Golang
export GOPATH=~/.go
export GOBIN=~/.go/bin
export PATH=$PATH:$GOBIN

# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
export PATH="$HOME/.cargo/bin/:$PATH"

# Personal
secrets=$HOME/Syncthing/SyncMisc/secrets.env
[ -f $secrets ] && source $secrets

# NVM/Node
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#[ -s "/usr/share/nvm/init-nvm.sh" ] && \. "/usr/share/nvm/init-nvm.sh"
PATH=$PATH:./node_modules/.bin:$HOME/.config/yarn/global/node_modules/.bin

# All of the languages
source $HOME/.asdf/asdf.sh

# Kubectl plugins
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:~/.kube/plugins/jordanwilson230

# Kubectl completions
source <(kubectl completion zsh)

# Record history in Erlang REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Python pip
export PATH="$HOME/.local/bin:$PATH"

# User binaries
export PATH="$HOME/bin:$PATH"

# Fuzzy finder
[ -f /usr/share/skim/completion.zsh ] && source /usr/share/skim/completion.zsh
[ -f /usr/share/skim/key-bindings.zsh ] && source /usr/share/skim/key-bindings.zsh

eval "$(starship init zsh)"
