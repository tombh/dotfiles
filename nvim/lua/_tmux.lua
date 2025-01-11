require("tmux").setup({
	copy_sync = {
		-- enables copy sync. by default, all registers are synchronized.
		-- to control which registers are synced, see the `sync_*` options.
		enable = false,
	},
	navigation = {
		-- cycles to opposite pane while navigating into the border
		cycle_navigation = true,

		-- enables default keybindings (C-hjkl) for normal mode
		enable_default_keybindings = false,

		-- prevents unzoom tmux when navigating beyond vim border
		persist_zoom = false,
	},
	resize = {
		-- enables default keybindings (A-hjkl) for normal mode
		enable_default_keybindings = true,

		-- sets resize steps for x axis
		resize_step_x = 1,

		-- sets resize steps for y axis
		resize_step_y = 1,
	},
})

_G.keymap("<M-Left>", function()
	require("tmux").move_left()
end)

_G.keymap("<M-Right>", function()
	require("tmux").move_right()
end)

_G.keymap("<M-Up>", function()
	require("tmux").move_top()
end)

_G.keymap("<M-Down>", function()
	require("tmux").move_bottom()
end)
