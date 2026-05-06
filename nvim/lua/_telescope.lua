require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = require("telescope.actions").close,
				["<C-v>"] = function()
					local clip = vim.fn.getreg("+")
					vim.api.nvim_put({ clip }, "c", true, true)
				end,
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

_G.keymap("<M-/>", "Telescope resume")
_G.keymap("<M-m>", "Telescope command_history")

_G.keymap("<M-G>", "Telescope git_status")
_G.keymap("<M-b>", "Telescope git_bcommits")

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

_G.keymap("<M-u>", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { 'method', 'function' } })
end)
