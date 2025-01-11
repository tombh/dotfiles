local is_github_theme_loaded, _ = pcall(require, "tokyonight")
if is_github_theme_loaded then
	---@class tokyonight.Config
	require("tokyonight").setup({
		style = "night",   -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
		transparent = true, -- Enable this to disable setting the background color
		lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme tables
		-- on_colors = function(_colors) end,

		--- You can override specific highlights to use other groups or a hex color
		--- function will be called with a Highlights and ColorScheme table
		on_highlights = function(highlights, colours)
			-- Borderless Telescope
			local prompt = "#2d3149"
			highlights.TelescopeNormal = {
				bg = colours.bg_dark,
				fg = colours.fg_dark,
			}
			highlights.TelescopeBorder = {
				bg = colours.bg_dark,
				fg = colours.bg_dark,
			}
			highlights.TelescopePromptNormal = {
				bg = prompt,
			}
			highlights.TelescopePromptBorder = {
				bg = prompt,
				fg = prompt,
			}
			highlights.TelescopePromptTitle = {
				bg = prompt,
				fg = prompt,
			}
			highlights.TelescopePreviewTitle = {
				bg = colours.bg_dark,
				fg = colours.bg_dark,
			}
			highlights.TelescopeResultsTitle = {
				bg = colours.bg_dark,
				fg = colours.bg_dark,
			}

			highlights.CursorLineNr = {
				bg = highlights.CursorLine.bg,
				fg = highlights.CursorLine.fg
			}


			-- TODO: They don't work 😢
			highlights.NonText = {
				fg = '#111111',
			}
			highlights.ExtraWhitespace = {
				bg = '#ff0000'
			}
		end,
	})

	vim.cmd([[colorscheme tokyonight]])
end
