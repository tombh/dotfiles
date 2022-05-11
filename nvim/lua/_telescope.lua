local defaults = {
	vimgrep_arguments = {
		"rg",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
	},
	prompt_prefix = "   ",
	selection_caret = "  ",
	entry_prefix = "  ",
	initial_mode = "insert",
	selection_strategy = "reset",
	sorting_strategy = "ascending",
	layout_strategy = "horizontal",
	layout_config = {
		horizontal = {
			prompt_position = "top",
			preview_width = 0.55,
			results_width = 0.8,
		},
		vertical = {
			mirror = false,
		},
		width = 0.87,
		height = 0.80,
		preview_cutoff = 120,
	},
	file_sorter = require("telescope.sorters").get_fuzzy_file,
	file_ignore_patterns = { "node_modules" },
	generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
	path_display = { "truncate" },
	winblend = 0,
	border = {},
	borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	color_devicons = true,
	use_less = true,
	set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	file_previewer = require("telescope.previewers").vim_buffer_cat.new,
	grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
	qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	-- Developer configurations: Not meant for general override
	buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	mappings = {
		i = { -- or `n`
			["<Esc>"] = require("telescope.actions").close,
		},
	},
}

require("telescope").setup({
	defaults = defaults,
	pickers = {
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
				},
				n = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
				},
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = 50,
						height = 20,
					},
				},
			}),
		},
	},
})

require("telescope").load_extension("ui-select")
local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")

local delta_status = previewers.new_termopen_previewer({
	get_command = function(entry)
		return { "git", "diff", entry.value }
	end,
})

local delta_bcommits = previewers.new_termopen_previewer({
	get_command = function(entry)
		return { "git", "diff", entry.value .. "^!", "--", entry.current_file }
	end,
})

_G.tombh_git_status = function(opts)
	local theme = require("telescope.themes").get_dropdown()
	opts = opts or theme
	opts.previewer = delta_status
	opts.layout_strategy = "vertical"
	opts.layout_config.height = 0.9
	opts.layout_config.vertical = { preview_height = 0.75 }
	opts.layout_config.width = 0.9
	builtin.git_status(opts)
end

_G.tombh_git_bcommits = function(opts)
	opts = opts or {}
	opts.previewer = delta_bcommits
	builtin.git_bcommits(opts)
end

vim.g.novim_mode_use_finding = 0
_G.keymap("<C-p>", "lua require('telescope.builtin').find_files()")
_G.keymap("<M-g>", "lua tombh_git_status()")
_G.keymap("<M-b>", "lua tombh_git_bcommits()")
_G.keymap("<M-x>", "lua require('telescope.builtin').buffers()")
_G.keymap("<C-f>", "lua require('telescope.builtin').current_buffer_fuzzy_find()")
_G.keymap("<M-l>", "Telescope resume")
_G.keymap("<M-f>", "lua require('telescope.builtin').live_grep()")
_G.keymap(
	"<M-F>",
	"lua require('telescope.builtin').live_grep({vimgrep_arguments = {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-uuu'}})"
)
_G.keymap("<M-p>", "lua require('telescope.builtin').commands()")
_G.keymap("<M-n>", "lua require('telescope.builtin').lsp_document_diagnostics()")
