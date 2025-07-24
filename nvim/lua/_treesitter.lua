require 'nvim-treesitter.configs'.setup {
	incremental_selection = {
		enable = true
	},
	ensure_installed = {},
	auto_install = false,
	highlight = {
		enable = false,
	},
}

-- Thanks to Xian Tang for the inspiration: https://github.com/xiantang/nvim-conf/blob/7c0d6cbf6d9fd7b6a8960de887db1109332419bf/lua/plugins/treesitter.lua#L62-L132
local ts_utils = require("nvim-treesitter.ts_utils")

local node_list = {}
local current_index = nil

local function find_expand_node(node)
	local start_row, start_col, end_row, end_col = node:range()
	local parent = node:parent()
	if parent == nil then
		return nil
	end
	local parent_start_row, parent_start_col, parent_end_row, parent_end_col = parent:range()
	if
			start_row == parent_start_row
			and start_col == parent_start_col
			and end_row == parent_end_row
			and end_col == parent_end_col
	then
		return find_expand_node(parent)
	end
	return parent
end

local function select_parent_node()
	if current_index == nil then
		return
	end

	local node = node_list[current_index - 1]
	local parent = nil
	if node == nil then
		parent = ts_utils.get_node_at_cursor()
	else
		parent = find_expand_node(node)
	end
	if not parent then
		vim.cmd("normal! gv")
		return
	end

	table.insert(node_list, parent)
	current_index = current_index + 1
	local start_row, start_col, end_row, end_col = parent:range()
	vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
	vim.cmd("normal! o")
	vim.fn.setpos(".", { 0, end_row + 1, end_col + 1, 0 })
end

local function start_select()
	node_list = {}
	current_index = nil
	current_index = 1
	local parent = ts_utils.get_node_at_cursor()
	table.insert(node_list, parent)
	vim.api.nvim_feedkeys(_G.replace_termcodes('<C-O>'), 'm', true)
	vim.cmd [[ call novim_mode#EnterSelectionMode('word') ]]
end

local function restore_last_selection()
	if not current_index or current_index <= 1 then
		return
	end

	current_index = current_index - 1
	local node = node_list[current_index]
	local start_row, start_col, end_row, end_col = node:range()
	vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
	vim.cmd("normal! o")
	vim.fn.setpos(".", { 0, end_row + 1, end_col + 1, 0 })
end

vim.api.nvim_create_autocmd('BufReadPre', {
	callback = function()
		_G.keymap(
			"<C-d>",
			start_select,
			select_parent_node
		)
	end,
})

_G.keymap(
	"<C-e>",
	start_select,
	restore_last_selection
)
