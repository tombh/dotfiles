[[ -o interactive ]] || return

_zshrc_finished=false

TRAPEXIT() {
	if [ $_zshrc_finished = false ]; then
		_debug "⚠ .zshrc didn't finish"
	else
		_debug "✨ .zshrc completed"
	fi
}

function _error () {
	>&2 echo "$1"
}

function _debug () {
	if [ "$ZSH_DEBUG" = 1 ]; then
		_error "$1"
	fi
}

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
bindkey  "^[[1~" beginning-of-line
bindkey  "^[[4~" end-of-line

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

# Aliases
alias 'rm'='rm -I'
alias 's'='sudo --preserve-env=PATH --preserve-env=HOME env'
alias 'se'='sudoedit'

alias 'p'='paru'
alias 'pS'='paru -S'
alias 'pR'='paru -Rsc'
alias 'pU'='tbx pacman_update'

alias 'dI'='sudo dnf install -y'
alias 'dR'='sudo dnf remove'
alias 'dU'='sudo dnf upgrade --refresh'

alias 'nI'='nix-env --install --attr'
alias 'nR'='nix-env --uninstall'
alias 'nU'='nix-env --upgrade'

alias 'gs'='git status -u'
alias 'o'='handlr open'
alias 'e'='nvim'
alias 'la'='
	lsd \
		--blocks date,user,size,name \
		--group-dirs first \
		--date relative \
		--sort time \
		--reverse\
		--almost-all'
alias 'laa'='lsd --long --git --almost-all'
alias 'lad'='la --sort time'
alias 'las'='la --sort size'
alias 'less'='less -r'
alias ff='fd . -type f -name'
alias be='bundle exec'
alias kc='kubectl'
alias grbim='~/bin/tbx git_rebase_interactive_detect_base'


function gbn {
	branch_name=$1
	git checkout -B "$branch_name" main
}

function ghcopr {
	export GH_FORCE_TTY=100%
	gh pr list | \
		fzf \
			--ansi \
			--preview 'gh pr view {1}' \
			--preview-window down --header-lines 3 |
		awk '{print $1}' |
		xargs gh pr checkout
}

function gcofz {
	git branch \
		--sort=-committerdate | \
		grep -v '^\*' | \
		fzf --reverse --info=inline | \
		xargs git checkout
}

# Pressing CTRL+SPACE after alias expands it
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey '^[ ' expand-alias

export FZF_CTRL_T_OPTS="
	--preview 'bat -n --color=always {}'
	--bind 'ctrl-/:change-preview-window(down|hidden|)'"

FZF_ALT_C_COMMAND="atuin search --format "{directory}" | rg -v "^unknown" | sort | uniq"
FZF_ALT_C_OPTS="--preview 'lsd --color always --tree {}'"

[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

ATUIN_NOBIND=1
eval "$(atuin init zsh --disable-up-arrow)"
bindkey '^r' _atuin_search_widget

# Multi-user (currently on remote Debian)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export EDITOR=$(which nvim)

# timg TTY image viewer: display images with correct aspect ratio on remote server
if [[ $(cat /etc/hostname) = "remote-box" ]]; then
	export TIMG_FONT_WIDTH_CORRECT=1.0
fi

# Set xterm option to enable CTRL-TAB, see:
# https://github.com/alacritty/alacritty/issues/4451
echo -ne '\e[>4;1m'

# This script was automatically generated by the broot program
# More information can be found in https://github.com/Canop/broot
# This function starts broot and executes the command
# it produces, if any.
# It's needed because some shell commands, like `cd`,
# have no useful effect if executed in a subshell.
function br {
	local cmd cmd_file code
	cmd_file=$(mktemp)
	if broot --outcmd "$cmd_file" "$@"; then
		cmd=$(<"$cmd_file")
		rm -f "$cmd_file"
		EDITOR=vi eval "$cmd"
	else
		code=$?
		rm -f "$cmd_file"
		return "$code"
	fi
}
zle -N br
bindkey '^b' br

# Prompt
eval "$(starship init zsh)"

# Rye Python and Python packages manager
[ -f "$HOME/.rye/env" ] && source "$HOME/.rye/env"

if [[ -n $ONEOFF ]]; then
	eval "$ONEOFF"
	exit
fi

_zshrc_finished=true

if [ -e /home/tombh/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tombh/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
