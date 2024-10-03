#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

ATUIN_DB_PATH=~/.local/share/atuin

function update_symlink {
	local file=$1
	local destination=$2
	ln -sf "$SCRIPT_DIR/$file" "$destination"
}

mkdir -p \
	~/bin \
	~/.xkb/symbols \
	~/.config/tmux \
	~/.config/broot \
	~/.config/tmux \
	~/.config/atuin \
	~/.config/gitui \
	~/.config/nix \
	~/.config/mako

update_symlink ../tbx/tbx ~/bin/tbx
update_symlink atuin/config.toml ~/.config/atuin/
update_symlink alacritty ~/.config/
update_symlink broot.toml ~/.config/broot/conf.toml
update_symlink nvim ~/.config/
update_symlink tmux/tmux.conf.theme ~/.config/tmux/theme.conf
update_symlink tmux/tmux.conf.main ~/.config/tmux/tmux.conf
update_symlink zshrc ~/.zshrc
update_symlink zimrc ~/.zimrc
update_symlink zprofile.zsh ~/.zprofile
update_symlink starship.toml ~/.config/
update_symlink xkb-gb-tombh ~/.xkb/symbols/gb-tombh
update_symlink sampler.yml ~/.config/
update_symlink bottom ~/.config/
update_symlink gitui.ron ~/.config/gitui/theme.ron
update_symlink nix.conf ~/.config/nix
update_symlink zellij ~/.config/

if [ "$USER" == "streamer" ]; then
	sudo ~/bin/tbx give_user_full_acl streamer "$ATUIN_DB_PATH"
	update_symlink ../config/atuin/streamer-db "$ATUIN_DB_PATH"
fi

if [ "$USER" == "tombh" ]; then
	if [ "$HOSTNAME" == remote-box ]; then
		update_symlink ../config/atuin/remote-db "$ATUIN_DB_PATH"
	else
		update_symlink ../config/atuin/tombh-db "$ATUIN_DB_PATH"
		update_symlink wayfire.ini ~/.config/
		update_symlink mako.ini ~/.config/mako/config
		update_symlink wob.ini ~/.config/
	fi
fi
