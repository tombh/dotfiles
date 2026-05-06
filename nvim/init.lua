require("_plugins")
require("_utils")
require("_colours")
require("_options")

require("_keymaps")
require("_neo-tree")
require("_tmux")
require("_lspconfig")
require("_noice")
require("_gitsigns")
require("_blink")
require("_status_line")
require("_formatting")
require("_scrollbar")
require("_telescope")
require("_treesitter")
require("_misc")

require('local-highlight').setup({
	insert_mode = true,
	animate = {
		enabled = false,
	},
})
require('nvim-autopairs').setup()
require("arborist").setup({
	install_popular = false,
	ensure_installed = {
		"rust"
	}
})

vim.cmd.packadd("novim-mode")
