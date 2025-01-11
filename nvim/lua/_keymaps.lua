_G.keymap = function(key, main_command, selection_command)
	local options = { noremap = true, silent = true }

	if type(main_command) == "string" then
		main_command = string.format("<cmd>%s<CR>", main_command)
	end

	vim.keymap.set({ "i", "n", "c" }, key, main_command, options)

	if selection_command then
		-- selection_command = string.format(":'<,'>%s<CR>", selection_command)
		main_command = selection_command
	end

	vim.keymap.set("v", key, main_command, options)
end

_G.keymap(
	"<C-_>",
	function() require('Comment.api').toggle.linewise.current() end,
	"<Plug>(comment_toggle_linewise_visual)"
)

_G.keymap("<C-w>", "call novim_mode#ClosePane()")
_G.keymap("<C-r>", "redo") -- Why doesn't `<C-y> or <C-S-Z>` work? 🥺
_G.keymap("<C-Tab>", "b #")

-- Jump history navigation
_G.keymap("<M-,>", 'exec "normal \\<C-o>"')
_G.keymap("<M-.>", 'exec "normal 1 \\<C-i>"')
