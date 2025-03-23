def --env load_keychain [] {
    let keychain_env = (
        keychain
            --eval
            --dir $"($env.HOME)/.config/keychain"
            --quiet
            --noask
            --agents gpg,ssh
            id_rsa id_ed25519_github
            | lines
            | where not ($it | is-empty)
            | parse "{k}={v}; export {k2};"
            | select k v
            | transpose --header-row
            | into record
    )

    # print $keychain_env
    $keychain_env | load-env
}

if (tty) == "/dev/tty1" or (tty) == "/dev/tty2" {
    load_keychain

    # Hack for when tmux-resurrect doesn't save the last state file
		# TODO: port to nushell? Or move to fish!??
    # pushd ~/.config/tmux/resurrect
    # 	ln -sf "$(ls -Art | tail -n3 | head -n1)" last
    # popd

    hide-env DISPLAY
		# Note that each user has its own `/run/user/1000/wayland-1`.
		# Therefore, user `streamer` won't have `wayland-2` for example.
    WAYLAND_DISPLAY="wayland-1" tmux start-server
    dbus-run-session /opt/wayfire/bin/wayfire > "~/log/wayfire.log"
    #   killall tmux
}

