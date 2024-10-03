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
	-- keymaps = {
	-- 	noremap = true,
	-- 	buffer = true,
	-- },
	watch_gitdir = {
		interval = 100,
		follow_files = true,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	word_diff = false,
	-- current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	-- current_line_blame_opts = {
	-- 	virt_text = true,
	-- 	virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
	-- 	delay = 1000,
	-- 	ignore_whitespace = false,
	-- },
	diff_opts = {
		internal = true,
	},
})

require("scrollbar.handlers.gitsigns").setup()
