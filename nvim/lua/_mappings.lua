string.startswith = function(self, str)
	return self:find('^' .. str) ~= nil
end

_G.keymap = function(key, main_command, selection_command)
	local command

	if string.startswith(main_command, "<") then
		command = main_command
	else
		command = string.format(":%s<CR>", main_command)
	end

	vim.api.nvim_set_keymap(
		"i",
		key,
		string.format("<C-O>%s", command),
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		key,
		command,
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"c",
		key,
		command,
		{ noremap = true, silent = true }
	)

	if selection_command then
		main_command = selection_command
	end

	if string.startswith(main_command, "<") then
		command = main_command
	else
		command = string.format(":'<,'>%s<CR>", main_command)
	end

	vim.api.nvim_set_keymap(
		"v",
		key,
		command,
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"s",
		key,
		string.format("<C-O>%s", command),
		{ noremap = true, silent = true }
	)
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
