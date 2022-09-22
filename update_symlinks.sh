#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function update_symlink {
	local file=$1
	local destination=$2
	ln -sf "$SCRIPT_DIR/$file" "$destination"
}

mkdir -p \
	~/.config/tmux \
	~/.config/broot \
	~/.config/tmux \
	~/.config/atuin

update_symlink atuin.toml ~/.config/atuin/config.toml
update_symlink alacritty ~/.config/alacritty
update_symlink broot.toml ~/.config/broot/conf.toml
update_symlink nvim ~/.config/
update_symlink tmux/tmux.conf.theme ~/.config/tmux/theme.conf
update_symlink tmux/tmux.conf.main ~/.config/tmux/tmux.conf
update_symlink zshrc ~/.zshrc
update_symlink zimrc ~/.zimrc
update_symlink zprofile ~/.zprofile
update_symlink starship.toml ~/.config/
update_symlink wayfire.ini ~/.config/
