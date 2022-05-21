local g = vim.g
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local is_github_theme_loaded, _ = pcall(require, "github-theme")
if is_github_theme_loaded then
	require("github-theme").setup({
		theme_style = "dimmed",
		transparent = true,
	})
end

require("_plugins")
if Packer_bootstrap then
	require("packer").sync()
end

vim.notify = require("notify")
vim.notify.setup({
	-- TODO: use colour name from _highlights.lua
	background_colour = "#1e222a"
})

require("_highlights")
require("_icon_overrides")
require("_mappings")
require("_misc-utils")
require("_statusline")
require("_autopairs")
require("_zenmode")
require("_neo-tree")
require("_treesitter")
require("_telescope")
require("_autocommands")
require("_gitsigns")

require("colorizer").setup()
require("neoscroll").setup()
require("Comment").setup()

-- lsp stuff
require("lspkind").init()
require("_lspconfig")
require("_null-ls")
require("_cmp-completion")

g.auto_save = 0

require("indent_blankline").setup {
	space_char_blankline      = " ",
	show_first_indent_level   = false,
	char_highlight_list       = {
		"IndentBlanklineIndent",
	},
	space_char_highlight_list = {
		"IndentBlanklineIndent",
	},
}

-- Make navigating between vim and tmux panes consistent
g.tmux_navigator_no_mappings = 1
g.novim_mode_use_pane_controls = 0

g.neoformat_enabled_python = { "black" }

g.better_whitespace_enabled = 1
g.strip_only_modified_lines = 1

g.minimap_auto_start = 1
g.minimap_highlight_range = 1
g.minimap_highlight_search = 1
g.minimap_git_colors = 1
g.minimap_width = 8
