require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = require("telescope.actions").close,
			},
		},
	},
	extensions = {
		-- Converts menus (eg LSP code actions) to Telescope UIs
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = 75,
						height = 25,
					},
				},
			}),
		},
	},
})
require("telescope").load_extension("ui-select")

_G.keymap("<C-p>", "Telescope find_files")

_G.keymap("<M-p>", function()
	require("telescope.builtin").commands()
end)

_G.keymap("<M-x>", function()
	require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
end)

vim.g.novim_mode_use_finding = 0
_G.keymap("<C-f>", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)

_G.keymap("<M-l>", "Telescope resume")
_G.keymap("<M-k>", "Telescope command_history")

_G.keymap("<M-f>", function()
	require("telescope.builtin").live_grep()
end)

_G.keymap("<M-F>", function()
	require("telescope.builtin").live_grep({
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"-uuu",
		},
	})
end)

_G.keymap("<M-j>", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = 'function' })
end)
