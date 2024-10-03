require("vim.lsp._watchfiles")._watchfunc = function(_, _, _)
	return true
end

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

require("_highlights")

require("_plugins")
if Packer_bootstrap then
	require("packer").sync()
end

local startswith = function(self, str)
	return self:find("^" .. str) ~= nil
end

_G.keymap = function(key, main_command, selection_command)
	local command

	if startswith(main_command, "<") then
		command = main_command
	else
		command = string.format("<cmd>%s<CR>", main_command)
	end

	vim.api.nvim_set_keymap("i", key, command, { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", key, command, { noremap = true, silent = true })
	vim.api.nvim_set_keymap("c", key, command, { noremap = true, silent = true })

	if selection_command then
		main_command = selection_command
	end

	if startswith(main_command, "<") then
		command = main_command
	else
		command = string.format(":'<,'>%s<CR>", main_command)
	end

	vim.api.nvim_set_keymap("v", key, command, { noremap = true, silent = true })
	vim.api.nvim_set_keymap("s", key, string.format("<C-O>%s", command), { noremap = true, silent = true })
end

require("_icon_overrides")
require("_misc-utils")
require("_statusline")
require("_autopairs")
require("_zenmode")
require("_treesitter")
require("_telescope")
require("_autocommands")
require("_gitsigns")
require("_github")
require("_mason")
require("_diffview")
require("colorizer").setup()
require("neoscroll").setup({})
require("Comment").setup()
require("local-highlight").setup({
	insert_mode = true,
})

-- lsp stuff
require("lspkind").init()
require("_lspconfig")
require("_cmp-completion")
require("_pygls_super_etc")

require("ibl").setup({
	indent = { highlight = "IndentBlanklineIndent", char = "" },
	whitespace = {
		highlight = "IndentBlanklineIndent",
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
})

require("_scrollbar")
require("_noice")

require("_mappings")
-- Last because of its <C-e> mapping
require("_neo-tree")

-- Make navigating between vim and tmux panes consistent
g.tmux_navigator_no_mappings = 1 -- TODO: am I still using this?
g.novim_mode_use_pane_controls = 0

g.better_whitespace_enabled = 1
g.strip_only_modified_lines = 1

g.himalaya_mailbox_picker = "telescope"

-- Show the highlight name under the current cursor
-- vim.cmd([[
-- 	function! SynGroup()
-- 		let l:s = synID(line('.'), col('.'), 1)
-- 		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
-- 	endfun
-- ]])

vim.filetype.add({
	extension = {
		vert = "glsl",
		frag = "glsl",
	},
})
