require("blink.cmp").setup(
	{
		keymap = {
			['<Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_next()
					end
				end,
				'snippet_forward',
				'fallback'
			},
			['<C-G>'] = { 'show' },
			['<M-g>'] = { 'show' },
			['<C-Up>'] = { 'select_prev', 'fallback' },
			['<C-Down>'] = { 'select_next', 'fallback' },
			['<C-Right>'] = { 'show_documentation', 'fallback' },
			['<C-Left>'] = { 'hide_documentation', 'cancel', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
			['<Up>'] = { 'cancel', 'fallback' },
			['<Down>'] = { 'cancel', 'fallback' },
			['<Esc>'] = { 'hide', 'fallback' },
		},
		completion = {
			trigger = {
				-- show_on_trigger_character = true,
				-- show_on_accept_on_trigger_character = true
			},
			menu = {
				-- auto_show = true,
				scrollbar = false,
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				}
			},
		},
		sources = {
			providers = {
				snippets = {
					opts = {
						-- TODO: file an issue about this in blink or rocks?
						search_paths = { "~/.local/share/nvim/site/pack/luarocks/opt/friendly-snippets/snippets/" }
					}
				}
			},
		}
	}
)
