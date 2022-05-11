local cmd = vim.cmd

local bg = function(group, col)
	cmd("hi " .. group .. " guibg=" .. col)
end

local fg = function(group, col)
	cmd("hi " .. group .. " guifg=" .. col)
end

local fg_bg = function(group, fgcol, bgcol)
	cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

local white = "#D4D4D4"
local black = "#1b1f27"
local black2 = "#1e222a"
local darker_black = "#0f0f0f"
local blue = "#61afef"
local green = "#A3BE8C"

fg_bg("VertSplit", darker_black, "bg")
bg("CursorLine", black2)

-- Telescope
bg("TelescopeNormal", darker_black)
fg_bg("TelescopeBorder", darker_black, darker_black)
fg_bg("TelescopePromptBorder", black2, black2)
fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", blue, black2)
fg_bg("TelescopePreviewTitle", black, green)
fg_bg("TelescopePromptTitle", black, blue)
fg_bg("TelescopeResultsTitle", darker_black, darker_black)
bg("TelescopeSelection", black2)

-- LSP Diagnostics
fg("LspDiagnosticsSignHint", "#868dba")
fg("LspDiagnosticsVirtualTextHint", "#868dde")
fg("LspDiagnosticsDefaultHint", "#EBCB8B")
