require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	default_component_configs = {
		modified = {
			symbol = "",
		},
	},
	filesystem = {
		use_libuv_file_watcher = true,
		follow_current_file = { enabled = true },
		hijack_netrw_behavior = "open_default",
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_hidden = false,
		},
	},
	window = {
		width = 30,
	},
})

_G.keymap("<C-e>", "Neotree focus")

_G.keymap("<C-M-e>", "Neotree show toggle")
_G.keymap("<C-M-g>", "Neotree float git_status")

vim.api.nvim_create_autocmd('UIEnter', {
	pattern = '*',
	callback = function()
		if vim.bo.filetype == "gitcommit" then
			return
		end

		-- The `vim.schedule` gives neo-tree a moment to set itself up to not be identified as
		-- a normal text file.
		if vim.bo.filetype ~= "" then
			if vim.fn.winwidth("%") > 120 then
				vim.schedule(function()
					vim.api.nvim_command("Neotree show")
				end)
			end
		else
			if vim.fn.winwidth("%") > 120 then
				-- Doesn't look like there's a file, so choose one
				-- TODO: But files without extensions, for example, don't report a filetype 🤔
				vim.schedule(function()
					vim.api.nvim_command("Neotree focus")
				end)
			end
		end
	end
})

vim.api.nvim_create_autocmd('FocusGained', {
	pattern = '*',
	callback = function()
		require("neo-tree.sources.manager").refresh("filesystem")
		require("neo-tree.events").fire_event("git_event")
	end
})
