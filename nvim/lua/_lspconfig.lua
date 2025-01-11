local servers = {
	"cssls",
	"stylelint_lsp",
	"rust_analyzer",
	"lua_ls",
	"bashls",
	"eslint",
	"html",
	"jsonls",
	"terraformls",
	"pyright",
	"gopls",
	"golangci_lint_ls",
	"vuels",
	"ruff",
	"ts_ls",
	"tinymist",
	"marksman",
	"nushell",

	--- Problems installing
	-- "solargraph",
	-- "wgsl_analyzer",
}

vim.diagnostic.config({
	underline = true,
	virtual_text = {
		spacing = 2,
	},
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

local function on_attach(_client, _bufnr)
	_G.keymap("<M-a>", vim.lsp.buf.code_action)
	_G.keymap("<M-e>", vim.diagnostic.open_float)
	_G.keymap("<M-R>", vim.lsp.buf.rename)
	_G.keymap("<M-?>", vim.lsp.buf.hover)

	_G.keymap("<M-S>", vim.lsp.buf.signature_help)
	_G.keymap("<M-T>", vim.lsp.buf.type_definition)
	_G.keymap("<M-D>", vim.lsp.buf.declaration)

	_G.keymap("<M-d>", function()
		require('telescope.builtin').lsp_definitions({ reuse_win = true })
	end)
	_G.keymap("<M-y>", function()
		require('telescope.builtin').lsp_references({ fname_width = 200 })
	end)
	_G.keymap("<M-i>", function()
		require('telescope.builtin').lsp_implementations({ fname_width = 200 })
	end)

	_G.keymap("<M-n>", function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end)
	_G.keymap("<M-N>", function() require('telescope.builtin').diagnostics({}) end)
end

for _, server in pairs(servers) do
	local capabiltiies = {}

	local config = {
		on_attach = on_attach,
		capabiltiies = require("blink.cmp").get_lsp_capabilities(capabiltiies),
	}

	if server == "lua_ls" then
		config.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "describe", "it", "before_each", "after_each" },
				},
			},
		}
	end

	if server == "rust_analyzer" then
		config.settings = {
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
				diagnostics = { disabled = { "inactive-code" } },
			},
		}
	end

	require("lspconfig")[server].setup(config)
end

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
