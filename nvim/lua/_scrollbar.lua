local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
	handle = {
		text                = " ",
		blend               = 20,
		color               = colors.bg_highlight,
		color_nr            = nil, -- cterm
		highlight           = "CursorLine",
		hide_if_all_visible = true, -- Hides handle if all lines are visible
	},
	marks = {
		GitAdd = {
			text = "│",
		},
		GitChange = {
			text = "│",
		},
	},
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
		"noice",
		"neo-tree",
	},
	handlers = {
		cursor = false,
		gitsigns = true, -- Requires gitsigns
	},
})
