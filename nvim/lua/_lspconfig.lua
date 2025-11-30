local servers = {
	"biome",
	"cssls",
	"stylelint_lsp",
	"rust_analyzer",
	"lua_ls",
	"bashls",
	-- "eslint",
	"jsonls",
	-- "terraformls",
	"pyright",
	"glsl_analyzer",
	-- "gopls",
	-- "golangci_lint_ls",
	-- "vuels",
	"ruff",
	"somesass_ls",
	"svelte",
	"ts_ls",
	-- "tinymist",
	-- "marksman",
	-- "nushell",
	"superhtml",

	--- Problems installing
	-- "wgsl_analyzer",
}

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "scss" },
		}),
	},
})

vim.diagnostic.config({
	underline = true,
	virtual_text = {
		spacing = 2,
	},
	virtual_lines = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	float = {
		show_header = true,
		source = "always",
		border = "none",
		focusable = false,
	},
	update_in_insert = true,
	flags = {
		debounce_text_changes = 1000,
	},
})

vim.lsp.config("*", {
	capabilities = vim.lsp.protocol.make_client_capabilities()
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			-- cargo = {
			-- 	cfgs = { spirv = "" },
			-- },
			checkOnSave = {
				overrideCommand = {
					"cargo",
					"clippy",
					"--message-format=json",
					"--all",
					"--all-targets",
					-- "--all-features",
					-- "--",
					-- "-W",
					-- "clippy::all",
					-- "-W",
					-- "clippy::pedantic",
					-- "-W",
					-- "clippy::restriction",
					-- "-W",
					-- "clippy::nursery",
					-- "-W",
					-- "clippy::cargo",
					-- "-W",
					-- "missing_docs",
				},
			},
			-- Just to get cfg(not(test)) to not show warning
			diagnostics = { disabled = { "inactive-code", "macro-error" } },
			-- completion = { autoimport = { enable = false } }
		},
	}
})


vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "describe", "it", "before_each", "after_each" },
			},
		},
	},
})

vim.lsp.config("biome", {
	-- The default causes `.git` to be preferred.
	-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/biome.lua
	-- Maybe I should submit a PR.
	root_dir = function(bufnr, on_dir)
		local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
		on_dir(project_root)
	end,
})

local is_mason_installed, _ = pcall(require, "mason")
if is_mason_installed then
	-- `nu` is already installed
	_G.removeByKey(servers, "nushell")

	require("mason").setup()
	require("mason-lspconfig").setup({
		-- A list of servers to automatically install if they're not already installed.
		-- This setting has no relation with the `automatic_installation` setting.
		---@type string[]
		ensure_installed = servers,

		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		-- Can either be:
		--   - false: Servers are not automatically installed.
		--   - true: All servers set up via lspconfig are automatically installed.
		--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
		--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
		---@type boolean
		automatic_installation = true,

		-- See `:h mason-lspconfig.setup_handlers()`
		---@type table<string, fun(server_name: string)>?
		handlers = nil,
	})
end

local function on_attach(client, bufnr)
	-- Prefer `biome`
	if
			client.name == "svelte" or
			client.name == "ts_ls" or
			client.name == "jsonls" or
			client.name == "stylelint_lsp" or
			client.name == "cssls"
	then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- Allow `svelete LSP` in `.svelte` files
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	if filetype == "svelte" and client.name == "svelte" then
		client.server_capabilities.documentFormattingProvider = true
	end

	_G.keymap("<M-a>", vim.lsp.buf.code_action)
	_G.keymap("<M-e>", vim.diagnostic.open_float)
	_G.keymap("<M-R>", vim.lsp.buf.rename)
	_G.keymap("<M-S>", vim.lsp.buf.hover)

	_G.keymap("<M-S>", vim.lsp.buf.signature_help)
	-- _G.keymap("<M-T>", vim.lsp.buf.type_definition)
	_G.keymap("<M-D>", vim.lsp.buf.declaration)

	_G.keymap("<M-d>", function()
		require('telescope.builtin').lsp_definitions({ reuse_win = true })
	end)
	_G.keymap("<M-y>", function()
		require('telescope.builtin').lsp_references(
			{
				include_declaration = false,
				reuse_win = true
			}
		)
	end)

	_G.keymap("<M-n>", function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end)
	_G.keymap("<M-N>", function() require('telescope.builtin').diagnostics({}) end)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client then
			on_attach(client, bufnr)
		end
	end,
})

vim.api.nvim_create_user_command("LSPInlayHintsEnable", function()
	vim.lsp.inlay_hint.enable(true)
end, {})

vim.api.nvim_create_user_command("LSPInlayHintsDisable", function()
	vim.lsp.inlay_hint.enable(false)
end, {})
