function _G.buffer_switch_mru()
	vim.cmd("b #")
end

_G.keymap("<C-Tab>", "lua buffer_switch_mru()")
_G.keymap("<C-t>", "enew")

_G.keymap("<S-M-Left>", "<C-W><Left>")
_G.keymap("<S-M-Right>", "<C-W><Right>")
_G.keymap("<S-M-Up>", "<C-W><Up>")
_G.keymap("<S-M-Down>", "<C-W><Down>")
_G.keymap(
	"<C-_>",
	"lua require('Comment.api').toggle.linewise.current()",
	"lua require('Comment.api').toggle.linewise('v')"
)
_G.keymap("<C-w>", "call novim_mode#ClosePane()")

_G.keymap("<M-h>", 'lua require"gitsigns".stage_hunk()')
_G.keymap("<M-H>", 'lua require"gitsigns".reset_hunk()')

-- Jump history navigation
_G.keymap("<M-,>", 'exec "normal \\<C-o>"')
_G.keymap("<M-.>", 'exec "normal 1 \\<C-i>"')

require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
	},
})

function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.keymap.set("v", "<C-d>", function()
	require("nvim-treesitter.incremental_selection").node_incremental()
	vim.cmd(t("normal <C-G><S-Right>"))
end, { noremap = true, silent = true })

vim.keymap.set("v", "<C-k>", function()
	require("nvim-treesitter.incremental_selection").scope_incremental()
	vim.cmd(t("normal <C-G><S-Right>"))
end, { noremap = true, silent = true })

vim.keymap.set("v", "<C-S-d>", function()
	require("nvim-treesitter.incremental_selection").node_decremental()
	vim.cmd(t("normal <C-G><S-Right>"))
end, { noremap = true, silent = true })
