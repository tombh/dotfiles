string.startswith = function(self, str)
	return self:find('^' .. str) ~= nil
end

_G.keymap = function(key, main_command, selection_command)
	local command

	if string.startswith(main_command, "<") then
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

	if string.startswith(main_command, "<") then
		command = main_command
	else
		command = string.format(":'<,'>%s<CR>", main_command)
	end

	vim.api.nvim_set_keymap("v", key, command, { noremap = true, silent = true })
	vim.api.nvim_set_keymap("s", key, string.format("<C-O>%s", command), { noremap = true, silent = true })
end

function _G.buffer_switch_mru()
	vim.cmd("b #")
end

_G.keymap("<C-Tab>", "lua buffer_switch_mru()")
_G.keymap("<C-t>", "enew")

_G.keymap("<C-C>", "OSCYank")

_G.keymap("<S-M-Left>", "<C-W><Left>")
_G.keymap("<S-M-Right>", "<C-W><Right>")
_G.keymap("<S-M-Up>", "<C-W><Up>")
_G.keymap("<S-M-Down>", "<C-W><Down>")
_G.keymap(
	"<C-_>",
	"lua require('Comment.api').toggle_current_linewise()",
	"lua require('Comment.api').toggle_linewise_op('v')"
)
_G.keymap("<C-w>", "call novim_mode#ClosePane()")

_G.keymap("<M-h>", 'lua require"gitsigns".stage_hunk()')
_G.keymap("<M-H>", 'lua require"gitsigns".reset_hunk()')

-- Jump history navigation
_G.keymap("<M-,>", 'exec "normal \\<C-o>"')
_G.keymap("<M-.>", 'exec "normal 1 \\<C-i>"')

require 'nvim-treesitter.configs'.setup {
	incremental_selection = {
		enable = true
	},
}

function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.select_object()
	vim.api.nvim_command('behave mswin')
	require('nvim-treesitter.incremental_selection').init_selection()
	vim.cmd(t('normal <C-G><S-Right>'))
end

function _G.inc_selection()
	vim.cmd(t('normal <C-G>'))
	require('nvim-treesitter.incremental_selection').node_incremental()
	vim.cmd(t('normal <C-G><S-Right>'))
end

_G.keymap("<C-d>", "lua select_object()", "lua inc_selection()")
