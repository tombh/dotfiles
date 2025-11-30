bind alt-c '
	cd $(
		atuin search --format "{directory}" |
			rg -v "^unknown" |
			awk \'!seen[$0]++\' |
			uniq |
			fzf --height=40%
	); commandline -f repaint
'

