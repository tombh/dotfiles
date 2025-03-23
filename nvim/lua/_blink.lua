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
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
			['<Up>'] = { 'hide', 'fallback' },
			['<Down>'] = { 'hide', 'fallback' },
			['<Esc>'] = { 'hide', 'fallback' },
		},
		completion = {
			trigger = {
				-- show_on_trigger_character = true,
				-- show_on_accept_on_trigger_character = true
			},
			menu = {
				-- auto_show = true,
				scrollbar = false
			}
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
