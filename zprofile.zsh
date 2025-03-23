export GTK_THEME=Adwaita:dark
export MOZ_ENABLE_WAYLAND=1
export MOZ_GTK_TITLEBAR_DECORATION=client
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=wayfire
export XDG_DATA_DIR=~/.local/share
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

export INPUT_METHOD=ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# export MESA_GL_VERSION_OVERRIDE=3.3
# export MESA_GLSL_VERSION_OVERRIDE=330
# export MESA_GLES_VERSION_OVERRIDE=3.1

export PATH=$PATH:/usr/sbin
export PAGER=less

# User binaries
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export COTP_DB_PATH=~/.config/cotp/db.cotp

# Nix package manager
# Single user (currently on my Fedora)
nix_init=$HOME/.nix-profile/etc/profile.d/nix.sh
[ -f $nix_init ] && source $nix_init

# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# Record history in Erlang REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Java / Android SDK
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/java-14-openjdk
export ANDROID_SDK_ROOT=~/Android/Sdk/
export ANDROID_HOME=$ANDROID_SDK_ROOT

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Python poetry
[ -f $HOME/.poetry/env ] && source $HOME/.poetry/env

# __pycache__
export PYTHONPYCACHEPREFIX=$HOME/.cache/pycache

# Golang
export GOPATH=~/.go
export GOBIN=~/.go/bin
export PATH=$PATH:$GOBIN

# Personal
secrets=$HOME/Syncthing/SyncMisc/secrets.env
[ -f $secrets ] && source $secrets

# NVM/Node
export PATH=$PATH:./node_modules/.bin:

# All of the languages
eval "$(mise activate zsh)"

# It's best for tmux to set TERM=tmux for various reasons, but for eveyrthing else we
# need this.
export TERM=xterm-256color

if [[ $(tty) = /dev/tty1 ]]; then
	eval $(keychain --eval --dir $HOME/.config/keychain --quiet --noask --agents gpg,ssh id_rsa)
	pushd ~/.config/tmux/resurrect
		ln -sf "$(ls -Art | tail -n3 | head -n1)" last
	popd
	WAYLAND_DISPLAY=wayland-1 tmux start-server
	exec wayfire > "$HOME/log/wayfire.log"
	killall tmux || true
fi

if [[ $(tty) = /dev/tty1 ]]; then
fi

if [[ $(tty) = /dev/tty2 ]]; then
fi
