local windline = require("windline")
local helper = require("windline.helpers")
local sep = helper.separators
local b_components = require("windline.components.basic")
local state = _G.WindLine.state
local vim_components = require("windline.components.vim")
local HSL = require("wlanimation.utils")

local lsp_comps = require("windline.components.lsp")
local git_comps = require("windline.components.git")

local hl_list = {
	Black = { "white", "black" },
	White = { "black", "white" },
	Normal = { "InactiveFg", "InactiveBg" },
	Inactive = { "InactiveBg", "InactiveBg" },
	Active = { "ActiveFg", "ActiveBg" },
}
local basic = {}

local airline_colors = {}

airline_colors.a = {
	NormalSep = { "magenta_a", "magenta_b" },
	InsertSep = { "green_a", "green_b" },
	VisualSep = { "yellow_a", "yellow_b" },
	ReplaceSep = { "blue_a", "blue_b" },
	CommandSep = { "red_a", "red_b" },
	Normal = { "black", "magenta_a" },
	Insert = { "white", "green_a" },
	Visual = { "black", "yellow_a" },
	Replace = { "black", "blue_a" },
	Command = { "black", "red_a" },
}

airline_colors.b = {
	NormalSep = { "magenta_b", "magenta_c" },
	InsertSep = { "green_b", "green_c" },
	VisualSep = { "yellow_b", "yellow_c" },
	ReplaceSep = { "blue_b", "blue_c" },
	CommandSep = { "red_b", "red_c" },
	Normal = { "white", "magenta_b" },
	Insert = { "white", "green_b" },
	Visual = { "white", "yellow_b" },
	Replace = { "white", "blue_b" },
	Command = { "white", "red_b" },
}

airline_colors.c = {
	NormalSep = { "magenta_c", "InactiveFg" },
	InsertSep = { "green_c", "InactiveFg" },
	VisualSep = { "yellow_c", "InactiveFg" },
	ReplaceSep = { "blue_c", "InactiveFg" },
	CommandSep = { "red_c", "InactiveFg" },
	Normal = { "white", "magenta_c" },
	Insert = { "white", "green_c" },
	Visual = { "white", "yellow_c" },
	Replace = { "white", "blue_c" },
	Command = { "white", "red_c" },
}

basic.divider = { b_components.divider, hl_list.Normal }

local width_breakpoint = 100

basic.section_a = {
	hl_colors = airline_colors.a,
	text = function(_, _, width)
		if width > width_breakpoint then
			return {
				{ " " .. state.mode[1] .. " ", state.mode[2] },
				{ sep.right_filled, state.mode[2] .. "Sep" },
			}
		end
		return {
			{ " " .. state.mode[1]:sub(1, 1) .. " ", state.mode[2] },
			{ sep.right_filled, state.mode[2] .. "Sep" },
		}
	end,
}

local get_git_branch = git_comps.git_branch()

basic.section_b = {
	hl_colors = airline_colors.b,
	text = function(_, _, width)
		local branch_name = get_git_branch()
		if width > width_breakpoint and #branch_name > 1 then
			return {
				{ branch_name, state.mode[2] },
				{ " ", "" },
				{ sep.right_filled, state.mode[2] .. "Sep" },
			}
		end
		return { { sep.right_filled, state.mode[2] .. "Sep" } }
	end,
}

basic.section_c = {
	hl_colors = airline_colors.c,
	text = function()
		return {
			{ " ", state.mode[2] },
			{ b_components.cache_file_name("[No Name]", "unique") },
			{ " " },
			{ sep.right_filled, state.mode[2] .. "Sep" },
		}
	end,
}

basic.section_x = {
	hl_colors = airline_colors.c,
	text = function(_, _, width)
		if width > width_breakpoint then
			return {
				{ sep.left_filled, state.mode[2] .. "Sep" },
				{ " ", state.mode[2] },
				{ b_components.file_encoding() },
				{ " " },
				{ b_components.file_format({ icon = true }) },
				{ " " },
			}
		end
		return {
			{ sep.left_filled, state.mode[2] .. "Sep" },
		}
	end,
}

basic.section_y = {
	hl_colors = airline_colors.b,
	text = function(_, _, width)
		if width > width_breakpoint then
			return {
				{ sep.left_filled, state.mode[2] .. "Sep" },
				{ b_components.cache_file_type({ icon = true }), state.mode[2] },
				{ " " },
			}
		end
		return { { sep.left_filled, state.mode[2] .. "Sep" } }
	end,
}

basic.section_z = {
	hl_colors = airline_colors.a,
	text = function(_, _, width)
		if width > width_breakpoint then
			return {
				{ sep.left_filled, state.mode[2] .. "Sep" },
				{ "", state.mode[2] },
				{ b_components.file_modified("   ") },
				{ b_components.progress_lua },
				{ " " },
				{ b_components.line_col_lua },
			}
		end
		return {
			{ sep.left_filled, state.mode[2] .. "Sep" },
			{ " ", state.mode[2] },
			{ b_components.line_col_lua, state.mode[2] },
		}
	end,
}

basic.lsp_diagnos = {
	name = "diagnostic",
	hl_colors = {
		red = { "red", "InactiveFg" },
		yellow = { "yellow", "InactiveFg" },
		blue = { "blue", "InactiveFg" },
	},
	text = function(bufnr)
		if lsp_comps.check_lsp(bufnr) then
			return {
				{ lsp_comps.lsp_error({ format = "  %s", show_zero = true }), "red" },
				{ lsp_comps.lsp_warning({ format = "  %s", show_zero = true }), "yellow" },
				{ lsp_comps.lsp_hint({ format = "  %s", show_zero = true }), "blue" },
			}
		end
		return { " ", "red" }
	end,
}

basic.git = {
	name = "git",
	width = width_breakpoint,
	hl_colors = {
		green = { "green", "InactiveBg" },
		red = { "red", "InactiveBg" },
		blue = { "blue", "InactiveBg" },
	},
	text = function(bufnr)
		if git_comps.is_git(bufnr) then
			return {
				{ git_comps.diff_added({ format = "  %s" }), "green" },
				{ git_comps.diff_removed({ format = "  %s" }), "red" },
				{ git_comps.diff_changed({ format = " 柳%s" }), "blue" },
			}
		end
		return ""
	end,
}

-- local quickfix = {
-- 	filetypes = { "qf", "Trouble" },
-- 	active = {
-- 		{ "🚦 Quickfix ", { "white", "black" } },
-- 		{ helper.separators.slant_right, { "black", "black_light" } },
-- 		{
-- 			function()
-- 				return vim.fn.getqflist({ title = 0 }).title
-- 			end,
-- 			{ "cyan", "black_light" },
-- 		},
-- 		{ " Total : %L ", { "cyan", "black_light" } },
-- 		{ helper.separators.slant_right, { "black_light", "InactiveBg" } },
-- 		{ " ", { "InactiveFg", "InactiveBg" } },
-- 		basic.divider,
-- 		{ helper.separators.slant_right, { "InactiveBg", "black" } },
-- 		{ "🧛 ", { "white", "black" } },
-- 	},
-- 	always_active = true,
-- 	show_last_status = true,
-- }

-- local explorer = {
-- 	filetypes = { "fern", "NvimTree", "lir" },
-- 	active = {
-- 		{ "  ", { "white", "magenta_b" } },
-- 		{ helper.separators.slant_right, { "magenta_b", "NormalBg" } },
-- 		{ b_components.divider, "" },
-- 		{ b_components.file_name(""), { "NormalFg", "NormalBg" } },
-- 	},
-- 	always_active = true,
-- 	show_last_status = true,
-- }

local default = {
	filetypes = { "default" },
	active = {
		basic.section_a,
		basic.section_b,
		basic.section_c,
		basic.lsp_diagnos,
		{ vim_components.search_count(), { "cyan", "NormalBg" } },
		basic.divider,
		basic.git,
		basic.section_x,
		basic.section_y,
		basic.section_z,
	},
	inactive = {
		{ b_components.full_file_name, hl_list.Inactive },
		{ b_components.divider, hl_list.Inactive },
		{ b_components.line_col, hl_list.Inactive },
		{ b_components.progress, hl_list.Inactive },
	},
}

windline.setup({
	colors_name = function(colors)
		local mod = function(c, value)
			if vim.o.background == "light" then
				return HSL.rgb_to_hsl(c):tint(value):to_rgb()
			end
			return HSL.rgb_to_hsl(c):shade(value):to_rgb()
		end

		colors.magenta_a = "#ccafe9"
		colors.magenta_b = mod(colors.magenta_a, 0.7)
		colors.magenta_c = mod(colors.magenta_a, 0.9)

		colors.yellow_a = "#baa03e"
		colors.yellow_b = mod(colors.yellow_a, 0.7)
		colors.yellow_c = mod(colors.yellow_a, 0.9)

		colors.blue_a = "#568ec5"
		colors.blue_b = mod(colors.blue_a, 0.7)
		colors.blue_c = mod(colors.blue_a, 0.9)

		colors.green_a = "#2b6a30"
		colors.green_b = mod(colors.green_a, 0.7)
		colors.green_c = mod(colors.green_a, 0.9)

		colors.red_a = "#d54e53"
		colors.red_b = mod(colors.red_a, 0.7)
		colors.red_c = mod(colors.red_a, 0.9)

		return colors
	end,
	statuslines = {
		default,
		-- quickfix,
		-- explorer,
	},
})

-- call it after you setup windline.
require("wlfloatline").setup()

-- default config
require("wlfloatline").setup({
	interval = 300,
	ui = {
		active_char = "▁",
		active_color = "blue",
		active_hl = nil,
	},
	skip_filetypes = {
		"NvimTree",
		"lir",
	},
	-- by default it skip all floating window but you can change it
	floating_show_filetypes = {},
})
