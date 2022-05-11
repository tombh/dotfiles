local ts_config = require("nvim-treesitter.configs")

ts_config.setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"bash",
		"lua",
		"json",
		"python",
		"rust",
		"go",
		"ruby",
	},
	highlight = {
		indent = true,
		enable = true,
		use_languagetree = true,
	},
	autopairs = { enable = true },
	indent = { enable = true },
})
