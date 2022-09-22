if [[ $(tty) = /dev/tty1 || $(tty) = /dev/tty2 ]]; then
	if [[ "$USER" == "streamer" ]]; then
		export CARGO_BUILD_JOBS=1
	fi

	eval $(keychain --eval --dir $HOME/.config/keychain --quiet --noask --agents gpg,ssh id_rsa)
	WAYLAND_DISPLAY=wayland-1 tmux start-server
	exec wayfire > "$HOME/wayfire.log"
fi

if [[ $(tty) = /dev/tty1 ]]; then
fi

if [[ $(tty) = /dev/tty2 ]]; then
fi

if [[ $(tty) = /dev/tty3 ]]; then
	exec zsh
fi


