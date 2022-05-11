local has_words_before = function()
	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")
local snippy = require("snippy")
local cmp = require("cmp")
vim.o.completeopt = "menuone,noselect"

local close = cmp.mapping({
	i = cmp.mapping.abort(),
	c = cmp.mapping.close(),
})

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			require("snippy").expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if cmp.get_selected_entry() then
					cmp.select_next_item()
				else
					fallback()
				end
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Up>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if cmp.get_selected_entry() then
					cmp.select_prev_item()
				else
					fallback()
				end
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Right>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if cmp.get_selected_entry() then
					cmp.confirm({ select = false })
				else
					fallback()
				end
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<Esc>"] = close,
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "snippy" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),

	formatting = {
		format = lspkind.cmp_format({
			with_text = false, -- do not show text alongside icons
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
