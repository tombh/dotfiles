_G.keymap = function(key, command, selection_command)
	vim.api.nvim_set_keymap("i", key, string.format("<C-O>:%s<CR>", command), { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", key, string.format(":%s<CR>", command), { noremap = true, silent = true })

	if selection_command then
		command = selection_command
	end

	vim.api.nvim_set_keymap("v", key, string.format(":'<,'>%s<CR>", command), { noremap = true, silent = true })
	vim.api.nvim_set_keymap("s", key, string.format("<C-O>:'<,'>%s<CR>", command), { noremap = true, silent = true })
end

_G.keymap("<C-C>", "OSCYank")

_G.keymap("<M-Left>", "TmuxNavigateLeft")
_G.keymap("<M-Right>", "TmuxNavigateRight")
_G.keymap("<M-Up>", "TmuxNavigateUp")
_G.keymap("<M-Down>", "TmuxNavigateDown")
_G.keymap(
	"<C-_>",
	"lua require('Comment.api').toggle_current_linewise()",
	"lua require('Comment.api').toggle_linewise_op('v')"
)
_G.keymap("<C-w>", "call novim_mode#ClosePane()")

_G.keymap("<M-h>", 'lua require"gitsigns".stage_hunk()')
_G.keymap("<M-H>", 'lua require"gitsigns".reset_hunk()')

_G.keymap("<M-,>", 'exec "normal \\<C-o>"')
_G.keymap("<M-.>", 'exec "normal 1 \\<C-i>"')
