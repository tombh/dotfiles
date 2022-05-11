local null_ls = require("null-ls")
null_ls.setup({
	on_attach = require("lsp-format").on_attach,
	sources = {
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.code_actions.gitsigns
	},
	update_in_insert = true,
})
