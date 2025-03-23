require("gitsigns").setup({
	signs = {
		add = { text = '┃' },
		change = { text = '┃' },
		topdelete = { text = "‾" },
		changedelete = { text = "—" },
		delete = { text = "_" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add          = { text = "│" },
		change       = { text = "│" },
		topdelete    = { text = '‾' },
		changedelete = { text = "—" },
		delete       = { text = '_' },
		untracked    = { text = '┆' },
	},
	signs_staged_enable = true,
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
		delay = 100,
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
_G.keymap("<M-P>", function()
	require("gitsigns").preview_hunk()
end)
