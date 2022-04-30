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
-- local red = "#571217"
local blue = "#61afef"
local green = "#A3BE8C"

-- fg_bg("Normal", white, black)
fg("IndentBlanklineChar", "#383c44")
--
-- -- misc --
-- cmd "hi Comment guifg=#42464e"
-- cmd "hi NvimInternalError guifg=#f9929b"
cmd("hi VertSplit guibg=#18191B")
-- cmd "hi EndOfBuffer guifg=#1e222a"
-- cmd "hi CursorLine guibg=#1e222a"
--
-- -- Pmenu
-- cmd "hi PmenuSel guibg=#98c379"
-- cmd "hi Pmenu  guibg=#282c34"
-- cmd "hi PmenuSbar guibg=#353b45"
-- cmd "hi PmenuThumb guibg=#81A1C1"
--
-- -- inactive statuslines as thin splitlines
-- cmd("highlight! StatusLineNC gui=underline guifg = #282b30")
--
-- -- git signs ---
-- cmd "hi DiffAdd guifg=#81A1C1 guibg = #1b1f27"
-- cmd "hi DiffChange guifg =#3A3E44 guibg = #1b1f27"
-- cmd "hi DiffModified guifg = #81A1C1 guibg = #1b1f27"
--
-- -- NvimTree
-- cmd "hi NvimTreeFolderIcon guifg = #61afef"
-- cmd "hi NvimTreeFolderName guifg = #61afef"
-- cmd "hi NvimTreeIndentMarker guifg=#383c44"
-- cmd "hi NvimTreeNormal guibg=#1b1f27"
-- cmd "hi NvimTreeVertSplit guifg=#1e222a"
-- cmd "hi NvimTreeRootFolder guifg=#f9929b"

-- Telescope
fg_bg("TelescopeBorder", darker_black, darker_black)
fg_bg("TelescopePromptBorder", black2, black2)

fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", blue, black2)

bg("TelescopeNormal", darker_black)

fg_bg("TelescopePreviewTitle", black, green)
fg_bg("TelescopePromptTitle", black, blue)
fg_bg("TelescopeResultsTitle", darker_black, darker_black)

bg("TelescopeSelection", black2)

--
-- -- LspDiagnostics ---
--
-- -- error
-- cmd "hi LspDiagnosticsSignError guifg=#f9929b"
-- cmd "hi LspDiagnosticsVirtualTextError guifg=#571217"
--
-- -- warnings
-- cmd "hi LspDiagnosticsSignWarning guifg=#EBCB8B"
-- cmd "hi LspDiagnosticsVirtualTextWarning guifg=#EBCB8B"
--
-- -- info
-- cmd "hi LspDiagnosticsSignInformation guifg=#A3BE8C"
-- cmd "hi LspDiagnosticsVirtualTextInformation guifg=#A3BE8C"
--
-- -- hint
cmd("hi LspDiagnosticsSignHint guifg=#868dba guibg=NONE")
cmd("hi LspDiagnosticsVirtualTextHint guifg=#868dde guibg=NONE")
--
-- -- Underline the offending code
-- cmd "hi LspDiagnosticsUnderlineError gui=NONE cterm=NONE guibg=#471217"
-- -- hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
-- -- hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
-- -- hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline
cmd("hi LspDiagnosticsDefaultHint guifg=#EBCB8B guibg=NONE")

-- Colours in completion list
-- cmd "highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6"
-- cmd "highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6"
-- cmd "highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0"
-- cmd "highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0"
-- cmd "highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE"
-- cmd "highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4"
