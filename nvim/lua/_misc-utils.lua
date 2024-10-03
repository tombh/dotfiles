local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

-- Can change to `vim.opt.` now
local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= "o" then
		scopes["o"][key] = value
	end
end

opt("o", "swapfile", false)
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", false)
opt("w", "cursorline", true)
opt("w", "cursorlineopt", "screenline") -- TODO: Add to Novim-mode?
opt("o", "numberwidth", 2)
opt("o", "showmode", false)
opt("o", "formatoptions", "tcr")
opt("o", "mouse", "a")
opt("o", "spell", true)

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 0)
opt("o", "laststatus", 0)
opt("o", "showcmd", false)

opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "timeoutlen", 500)

-- for indenline
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)

opt("o", "wrap", false)
opt("o", "fillchars", "eob: ,diff: ,foldopen:▾,foldsep:│,foldclose:▸") -- this slash isn't lining up ╱

-- Let arrow keys cross start-end of lines
-- TODO: Add this to novim-mode?
vim.cmd("set whichwrap+=<,>,[,]")

opt("w", "scrolloff", 10)
opt("o", "smoothscroll", true) -- I thought this would allow oneline window scrolling of wrapped paragraphs
-- opt("o", "sidescroll", true)
opt("o", "list", true)
opt("o", "listchars", "tab:——,eol:↲,nbsp:␣,trail: ,extends:⟩,precedes:⟨")

opt("o", "guifont", "SauceCodePro Nerd Font:h12")

vim.g.omni_sql_no_default_maps = 1

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

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
