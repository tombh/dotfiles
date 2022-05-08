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

# Include hidden files in completions
setopt globdots

# Just type the name of a cd'able location and press return to get there
setopt auto_cd

# Ensure Home/End do what their meant to
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

## Require marlonrichert/zsh-edit plugin
# CTRL+ARROW to move by words
bindkey "^[[1;5C" forward-subword
bindkey "^[[1;5D" backward-subword
# CTRL+BACKSPACE deletes whole word
bindkey "^H" backward-kill-subword

# Bind UP/DOWN to search through history
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

# Aliases
alias 's'='sudo -E '
alias 'se'='sudoedit'
alias 'p'='paru'
alias 'pS'='paru -S'
alias 'pR'='paru -Rsc'
alias 'gs'='git status -u'
alias 'o'='handlr open'
alias 'e'='nvim'
alias 'l'='exa --long --tree --level=2 --git --all'
alias 'la'='exa --long --git --all'
alias 'ls'='exa --grid'
alias 'less'='less -r'
alias ff='fd . -type f -name'
alias be='bundle exec'
alias kc='kubectl'

# Pressing CTRL+SPACE after alias expands it
function expand-alias() {
    zle _expand_alias
    zle self-insert
}
zle -N expand-alias
bindkey '^[ ' expand-alias

## Fuzzy finder
export SKIM_DEFAULT_COMMAND="fd --hidden --exclude 'cache' --exclude '.git' . $HOME"
export SKIM_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export SKIM_CTRL_T_OPTS="--preview='head -n10 {}'"
export SKIM_ALT_C_COMMAND="fd --hidden --exclude '*cache*' --exclude '.git' -t d . $HOME"
export SKIM_ALT_C_OPTS="--preview='exa --tree --level=2 --colour=always {}'"
[ -f /usr/share/skim/completion.zsh ] && source /usr/share/skim/completion.zsh
[ -f /usr/share/skim/key-bindings.zsh ] && source /usr/share/skim/key-bindings.zsh

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

eval `ssh-agent` >/dev/null

# Python poetry
[ -f $HOME/.poetry/env ] && source $HOME/.poetry/env

# __pycache__
export PYTHONPYCACHEPREFIX=$HOME/.cache/pycache

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
export PATH=$PATH:./node_modules/.bin:$HOME/.config/yarn/global/node_modules/.bin/

# Deno
which deno >/dev/null && export DENO_VERSION=$(deno -V | cut -d " " -f 2)
export PATH=$PATH:$HOME/.asdf/installs/deno/$DENO_VERSION/.deno/bin

# All of the languages
source $HOME/.asdf/asdf.sh

# Kubectl plugins
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.kube/plugins/jordanwilson230:$PATH"

# Kubectl completions
source <(kubectl completion zsh)

# Record history in Erlang REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Python pip
export PATH="$HOME/.local/bin:$PATH"

# User binaries
export PATH="$HOME/bin:$PATH"

# Java / Android SDK
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/java-14-openjdk
export ANDROID_SDK_ROOT=~/Android/Sdk/
export ANDROID_HOME=$ANDROID_SDK_ROOT

# Set xterm option to enable CTRL-TAB, see:
# https://github.com/alacritty/alacritty/issues/4451
echo -ne '\e[>4;1m'

# It's best for tmux to set TERM=tmux for various reasons, but for eveyrthing else we
# need this.
export TERM=xterm-256color

# Intelligent history search
export MCFLY_DISABLE_MENU=TRUE
eval "$(mcfly init zsh)"

# Autojump paths
eval "$(zoxide init zsh)"

# Prompt
eval "$(starship init zsh)"
