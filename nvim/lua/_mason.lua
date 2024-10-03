local is_mason_installed, _ = pcall(require, "mason")
if is_mason_installed then
	require("mason").setup()
	require("mason-lspconfig").setup({
		-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
		-- This setting has no relation with the `automatic_installation` setting.
		---@type string[]
		ensure_installed = {
			"eslint",
			"jsonls",
			"html",
			"cssls",
			"stylelint_lsp",
			"pyright",
			"ruff_lsp",
			"lua_ls",
			"bashls",
			"gopls",
			"golangci_lint_ls",
			"rust_analyzer",
			"solargraph",
			"terraformls",
			"ts_ls",
			"typst_lsp",
			"marksman",
			-- "glsl_analyzer", -- panics
		},

		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		-- Can either be:
		--   - false: Servers are not automatically installed.
		--   - true: All servers set up via lspconfig are automatically installed.
		--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
		--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
		---@type boolean
		automatic_installation = false,

		-- See `:h mason-lspconfig.setup_handlers()`
		---@type table<string, fun(server_name: string)>?
		handlers = nil,
	})
end
