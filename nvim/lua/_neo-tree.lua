_G.keymap("<C-e>", "NeoTreeFocusToggle")

require("neo-tree").setup({
	filesystem = {
		follow_current_file = true
	}
})
