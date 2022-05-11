local cmd = vim.cmd
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
require("custom_highlights")

require("pluginList")
if Packer_bootstrap then
	require("packer").sync()
end

vim.notify = require("notify").setup({
	background_colour = "#1e222a"
})

require("file-icons")
require("mappings")
require("misc-utils")
require("statusline")
require("autopairs")
require("zenmode-nvim")

require("colorizer").setup()
require("neoscroll").setup()
require("Comment").setup()

-- lsp stuff
require("nvim-lspconfig")
require("null-ls-nvim")
require("cmp-completion")

require("_neo-tree")

g.auto_save = 0

-- colorscheme related stuff
cmd("syntax on")

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = { "help", "terminal" }
g.indent_blankline_buftype_exclude = { "terminal" }
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

require("treesitter-nvim")
require("telescope-nvim")

-- git signs , lsp symbols etc
require("gitsigns-nvim")
require("lspkind").init()
require("_autocommands")

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

function _G.buffer_switch_mru()
	vim.cmd("b #")
end

_G.keymap("<C-Tab>", "lua buffer_switch_mru()")
_G.keymap("<C-t>", "enew")

vim.cmd("set wrap!")
-- vim.api.nvim_set_option("wrap", false)
