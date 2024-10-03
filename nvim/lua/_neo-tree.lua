require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	default_component_configs = {
		modified = {
			symbol = "",
		},
		icon = {
			folder_empty = "󰜌",
			folder_empty_open = "󰜌",
		},
		git_status = {
			symbols = {
				modified = "",
				renamed = "󰁕",
				unstaged = "󰄱",
			},
		},
	},
	document_symbols = {
		kinds = {
			File = { icon = "󰈙", hl = "Tag" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Property = { icon = "󰆧", hl = "@property" },
			Enum = { icon = "󰒻", hl = "@number" },
			Function = { icon = "󰊕", hl = "Function" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Struct = { icon = "󰌗", hl = "Type" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },
			StaticMethod = { icon = "󰠄 ", hl = "Function" },
		},
	},
	filesystem = {
		use_libuv_file_watcher = true,
		follow_current_file = { enabled = true },
		hijack_netrw_behavior = "open_default",
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_hidden = false,
		},
	},
	window = {
		width = 30,
	},
})

_G.keymap("<C-S-e>", "Neotree show toggle")
_G.keymap("<C-M-g>", "Neotree float git_status")

function _G.neotree_focus_toggle()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd(t("normal <S-M-Right>"))
	else
		vim.cmd("Neotree focus")
	end
end

_G.keymap("<C-e>", "lua neotree_focus_toggle()")
