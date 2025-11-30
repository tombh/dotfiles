require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 50,
		},
	},
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1,
				symbols = {
					modified = "  ", -- Text to show when the file is modified.
					readonly = " ", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
		},
		lualine_b = {
			"branch",
			-- { "diff", symbols = { added = " ", modified = " ", removed = " " } },
			{
				"diagnostics",
				update_in_insert = true,
				symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
			},
		},
		lualine_c = {},
		lualine_x = { "filetype" },
		lualine_y = { "lsp_status" },
		lualine_z = { "location" },
	},
	lualine_c = {},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "neo-tree", "mason" },
})
