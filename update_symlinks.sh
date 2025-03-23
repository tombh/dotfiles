#!/usr/bin/env bash

set -e
set -x

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

ATUIN_DB_PATH=~/.local/share/atuin
DOTISH_PATH=/publicish/syncable
SYNCMISC_PATH=/home/tombh/Syncthing/SyncMisc

if [ "$HOSTNAME" == remote-box ]; then
	DOTISH_PATH=/home/tombh/storage/Syncthing/Dotish
	SYNCMISC_PATH=/home/tombh/storage/Syncthing/SyncMisc
fi

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
	~/.config/htop \
	~/.config/gitui \
	~/.config/nix \
	~/.config/nushell \
	~/.config/mako

# Sync seperately to work around the history file
update_symlink nushell/scripts ~/.config/nushell
update_symlink nushell/config.nu ~/.config/nushell
update_symlink nushell/env.nu ~/.config/nushell

# ZSH
update_symlink zshrc ~/.zshrc
update_symlink zimrc ~/.zimrc
update_symlink zprofile.zsh ~/.zprofile

update_symlink gitconfig.toml ~/.gitconfig_public
update_symlink atuin ~/.config/
update_symlink broot.toml ~/.config/broot/conf.toml
update_symlink nvim ~/.config/
update_symlink fontconfig ~/.config/
update_symlink htoprc ~/.config/htop/
update_symlink tmux/tmux.conf.theme ~/.config/tmux/theme.conf
update_symlink tmux/tmux.conf.main ~/.config/tmux/tmux.conf
update_symlink xkb-gb-tombh ~/.xkb/symbols/gb-tombh
update_symlink sampler.yml ~/.config/
update_symlink bottom ~/.config/
update_symlink gitui.ron ~/.config/gitui/theme.ron
update_symlink nix.conf ~/.config/nix
update_symlink zellij ~/.config/

if [ "$HOSTNAME" != remote-box ]; then
	ln -sf /publicish/SourceCodeProNerd ~/.local/share/fonts
	update_symlink alacritty ~/.config/
	update_symlink wayfire.ini ~/.config/
	update_symlink mako.ini ~/.config/mako/config
	update_symlink wob.ini ~/.config/
	update_symlink waybar ~/.config/
fi

if [ "$USER" == "tombh" ]; then
	update_symlink starship.toml ~/.config/

	if [ "$HOSTNAME" == remote-box ]; then
		ln -sf "$DOTISH_PATH"/tbx/tbx ~/bin/tbx
		ln -sf "$SYNCMISC_PATH"/config/atuin/remote-db "$ATUIN_DB_PATH"
	else
		ln -sf "$DOTISH_PATH"/tbx/tbx ~/bin/tbx
		ln -sf "$SYNCMISC_PATH"/config/atuin/tombh-db "$ATUIN_DB_PATH"
	fi
fi

if [ "$USER" == "streamer" ]; then
	ln -sf "$DOTISH_PATH"/tbx/tbx ~/bin/tbx
	ln -sf /publicish/atuin-streamer-db "$ATUIN_DB_PATH"
	update_symlink starship_streamer.toml ~/.config/starship.toml
fi
