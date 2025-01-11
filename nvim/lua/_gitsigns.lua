require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "—" },
		untracked = { text = "┆" },
	},
	numhl = false,
	linehl = false,
	watch_gitdir = {
		interval = 100,
		follow_files = true,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	word_diff = false,
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	diff_opts = {
		internal = true,
	},
})

require("scrollbar.handlers.gitsigns").setup()

_G.keymap("<M-h>", function()
	require("gitsigns").stage_hunk()
end)
_G.keymap("<M-H>", function()
	require("gitsigns").reset_hunk()
end)

vim.api.nvim_create_autocmd({ 'FocusGained', 'VimEnter' }, {
	pattern = '*',
	callback = function()
		-- TODO: remove this, once https://github.com/lewis6991/gitsigns.nvim/issues/1122 is resolved
		vim.cmd([[Gitsigns detach_all]])
		vim.cmd([[Gitsigns attach]])
	end
})
