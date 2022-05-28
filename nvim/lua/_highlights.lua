local is_github_theme_loaded, _ = pcall(require, "github-theme")
if is_github_theme_loaded then
  require("github-theme").setup({
    theme_style = "dimmed",
    transparent = true,
    overrides = function(c)
      return {
        DiffAdd = {
          bg = c.diff.add,
        },
        DiffChange = {},
        DiffDelete = {
          bg = c.diff.delete,
        },
        DiffText = { bg = c.diff.change },
      }
    end,
  })
end

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

fg("NonText", '#111111')
fg("IndentBlanklineIndent", '#111111')

fg_bg("VertSplit", darker_black, "bg")
fg_bg("FoldColumn", black3, "bg")
fg_bg("Folded", black3, "bg")

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
