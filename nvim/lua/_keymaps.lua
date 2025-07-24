local options = { noremap = true, silent = true }
_G.keymap = function(key, main_command, selection_command)
	if type(main_command) == "string" then
		main_command = string.format("<cmd>%s<CR>", main_command)
	end

	vim.keymap.set({ "i", "n", "c" }, key, main_command, options)

	if selection_command then
		main_command = selection_command
	end

	vim.keymap.set("v", key, main_command, options)
end

-- Make undo history have higher detail
vim.keymap.set("i", "<Space>", "<Space><C-g>u", options)
vim.keymap.set("i", "<Return>", "<Return><C-g>u", options)

_G.keymap(
	"<C-_>",
	function() require('Comment.api').toggle.linewise.current() end,
	"<Plug>(comment_toggle_linewise_visual)"
)

_G.keymap("<C-w>", "call novim_mode#ClosePane()")
_G.keymap("<C-r>", "redo") -- Why doesn't `<C-y> or <C-S-Z>` work? 🥺
_G.keymap("<C-M-j>", "b #")

-- Copy current line
_G.keymap("<C-M-l>", function()
	vim.cmd([[ normal g^vg$"+y$ ]])
end)

-- Jump history navigation
_G.keymap("<M-,>", 'exec "normal \\<C-o>"')
_G.keymap("<M-i>", 'exec "normal 1 \\<C-i>"')
-- Move cursor line to center of screen
_G.keymap("<C-i>",
	function()
		vim.cmd [[ normal zz ]]
	end
)
