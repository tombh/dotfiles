local is_github_theme_loaded, _ = pcall(require, "tokyonight")
if is_github_theme_loaded then
	require("tokyonight").setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
		transparent = true, -- Enable this to disable setting the background color
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "dark", -- style for sidebars, see below
			floats = "dark", -- style for floating windows
		},
		sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
		hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		dim_inactive = true, -- dims inactive windows
		lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme table
		---@param colors ColorScheme
		on_colors = function(colors) end,

		--- You can override specific highlights to use other groups or a hex color
		--- function will be called with a Highlights and ColorScheme table
		---@param highlights Highlights
		---@param colors ColorScheme
		on_highlights = function(highlights, colors) end,
	})
	vim.cmd([[colorscheme tokyonight]])
end

local cmd = vim.cmd

local bg = function(group, col)
	cmd("highlight " .. group .. " guibg=" .. col)
end

local fg = function(group, col)
	cmd("highlight " .. group .. " guifg=" .. col)
end

local fg_bg = function(group, fgcol, bgcol)
	cmd("highlight " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

local white = "#D4D4D4"
local black = "#1b1f27"
local black2 = "#1e222a"
local black3 = "#40525a"
local darker_black = "#0f0f0f"
local blue = "#61afef"
local green = "#A3BE8C"

fg("NonText", "#111111")
fg("IndentBlanklineIndent", "#111111")

fg_bg("VertSplit", darker_black, "bg")
fg_bg("FoldColumn", black3, "bg")
fg_bg("Folded", black3, "bg")

bg("CursorLine", black2)
bg("NeoTreeCursorLine", "#20323a")

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

fg("NeoTreeGitIgnored", "#404040")
