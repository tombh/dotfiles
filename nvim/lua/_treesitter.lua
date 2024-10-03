local ts_config = require("nvim-treesitter.configs")

ts_config.setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"bash",
		"glsl",
		"lua",
		"json",
		"python",
		"rust",
		"sql",
		"go",
		"ruby",
		"graphql",
		"terraform",
		"markdown",
		"markdown_inline",
		"regex",
		"yaml",
	},
	highlight = {
		indent = true,
		enable = true,
		use_languagetree = true,
	},
	autopairs = { enable = true },
	indent = { enable = true },
})
