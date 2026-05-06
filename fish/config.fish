if status is-interactive
		fish_add_path ~/.cargo/bin
		fish_add_path ~/bin
		set --universal fish_greeting ""
		set --global fish_key_bindings fish_default_key_bindings

		export FZF_DEFAULT_COMMAND="fd . $HOME /publicish"
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
		fzf --fish | FZF_ALT_C_COMMAND= source
		
		starship init fish | source

		# Cached to conf.d/atuin.fish.
		# Waiting for: https://github.com/atuinsh/atuin/issues/2718
		# atuin init fish | source
		. ~/.config/fish/atuin.fish
		
		. ~/.nix-profile/etc/profile.d/nix.fish
		mise activate fish | source
		if test -e "/home/linuxbrew/.linuxbrew/bin/brew"
		  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    end

		set --global --export WAYLAND_DISPLAY wayland-1
		set --global --export GTK_THEME "Adwaita:dark"
    set --global --export EDITOR "nvim"
		# export $VK_ICD_FILENAMES="/usr/share/vulkan/icd.d"
		
		set --global --export GOPATH ~/.go
    set --global --export GOBIN ~/.go/bin
    fish_add_path ~/.go/bin
		
		set --global --export GPG_TTY $(tty)
		gpg-connect-agent updatestartuptty /bye >/dev/null

		alias rm='rm -I'
		alias s='sudo --preserve-env=PATH --preserve-env=HOME env'
		alias se='sudoedit'

		alias dI='sudo dnf install -y'
		alias dR='sudo dnf remove'
		alias dU='sudo dnf upgrade --refresh'

		alias nI='nix-env --install --attr'
		alias nR='nix-env --uninstall'
		alias nU='nix-env --upgrade'

		alias gs='git status -u'
		abbr --add gds 'git diff --staged'
		alias o='xdg-open'
		alias e='nvim'
		alias la='lsd \
								--blocks date,user,size,name \
								--group-dirs first \
								--date relative \
								--sort time \
								--reverse\
								--almost-all'
		alias laa='lsd --long --git --almost-all'
		alias lad='la --sort time'
		alias las='la --sort size'
		alias less='less -r'
		alias y='WAYLAND_DISPLAY="" DISPLAY="" XDG_SESSION_TYPE="" YAZI_IMAGE_BACKEND=chafa yazi'

		if test (tty) = /dev/tty1; or test (tty) = /dev/tty2;
			set --erase WAYLAND_DISPLAY # Because you can't start `wayfire` with this already set
			pushd ~/.config/tmux/resurrect
				ln -sf "$(ls -Art | tail -n3 | head -n1)" last
			popd
		end
end
