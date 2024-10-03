local has_words_before = function()
	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")
-- local snippy = require("snippy")
local cmp = require("cmp")
-- vim.o.completeopt = "menuone,noselect"

local close = cmp.mapping({
	i = cmp.mapping.abort(),
	c = cmp.mapping.close(),
})

cmp.setup({
	completion = {
		autocomplete = false,
	},
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif snippy.can_jump(1) then
				-- 	snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				-- elseif snippy.can_jump(-1) then
				-- 	snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Up>"] = cmp.mapping(function(fallback)
			fallback()
			if cmp.visible() then
				cmp.close()
			end
		end, { "i" }),
		["<Down>"] = cmp.mapping(function(fallback)
			fallback()
			if cmp.visible() then
				cmp.close()
			end
		end, { "i" }),
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
			-- prevent the popup from showing more than provided characters
			-- (e.g 50 will not show more than 50 characters)
			maxwidth = 50,

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization.
			-- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = "buffer" },
-- 	},
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
