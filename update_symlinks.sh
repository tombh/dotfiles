#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function update_symlink {
	local file=$1
	local destination=$2
	ln -sf "$SCRIPT_DIR/$file" "$destination"
}

update_symlink nvim ~/.config/nvim
update_symlink alacritty.yml ~/.config/alacritty/
update_symlink tmux/.tmux.conf.theme ~/.config/tmux/theme.conf
update_symlink tmux/.tmux.conf.main ~/.config/tmux/tmux.conf
update_symlink .zshrc ~/
update_symlink .zimrc ~/
update_symlink starship.toml ~/.config/
update_symlink wayfire.ini ~/.config/
