_G.keymap("<C-e>", "NeoTreeFocusToggle")

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	default_component_configs = {
		modified = {
			symbol = "",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_default",
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_hidden = false
		}
	},
	window = {
		width = 30,
	},
})
