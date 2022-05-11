local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= "o" then
		scopes["o"][key] = value
	end
end

opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", false)
opt("w", "cursorline", true)
opt("o", "numberwidth", 2)
opt("o", "showmode", false)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "timeoutlen", 500)

-- for indenline
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)

opt("o", "wrap", false)
opt("o", 'fillchars', 'eob: ')

-- Let arrow keys cross start-end of lines
-- TODO: Add this to novim-mode?
vim.cmd('set whichwrap+=<,>,[,]')

opt("o", "sidescroll", true)
opt("o", "list", true)
opt("o",
	'listchars',
	'tab:——,eol:↲,nbsp:␣,trail: ,extends:⟩,precedes:⟨'
)

local M = {}

function M.is_buffer_empty()
	-- Check whether the current buffer is empty
	return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
	-- Check if the windows width is greater than a given number of columns
	return vim.fn.winwidth(0) / 2 > cols
end

return M
