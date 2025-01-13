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

if (tty) == "/dev/tty1" {
    load_keychain

    # pushd ~/.config/tmux/resurrect
    # 	ln -sf "$(ls -Art | tail -n3 | head -n1)" last
    # popd

    hide-env DISPLAY
    WAYLAND_DISPLAY=wayland-1 tmux start-server
    wayfire > "~/log/wayfire.log"
    #   killall tmux
}

