require("neodev").setup({})

local util = require("lspconfig.util")

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

vim.lsp.set_log_level("debug")

local function on_attach(client, bufnr)
	-- TODO: Move to my _G.keymap()
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = false }
	vim.keymap.set("i", "<M-a>", vim.lsp.buf.code_action, { noremap = true })
	buf_set_keymap("i", "<M-D>", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("i", "<M-d>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "<M-d>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("i", "<M-?>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- buf_set_keymap("i", "<M-S>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("i", "<M-e>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("i", "<M-T>", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("i", "<M-R>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap(
		"i",
		"<M-y>",
		"<cmd>lua require('telescope.builtin').lsp_references({ fname_width = 200 })<CR>",
		opts
	)
	-- buf_set_keymap("i", "<M-I>", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap(
		"i",
		"<M-i>",
		"<cmd>lua require('telescope.builtin').lsp_implementations({ fname_width = 200 })<CR>",
		opts
	)
	buf_set_keymap(
		"i",
		"<M-d>",
		"<cmd>lua require('telescope.builtin').lsp_definitions({ reuse_win = true })<CR>",
		opts
	)

	-- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	-- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

-- TODO feed to mason-lspconfig for auto install
local servers = {
	"cssls",
	"stylelint_lsp",
	"rust_analyzer",
	"lua_ls",
	"bashls",
	"eslint",
	"html",
	"jsonls",
	-- "denols",
	"solargraph",
	"terraformls",
	"pyright",
	"gopls",
	"golangci_lint_ls",
	"vuels",
	"ruff_lsp",
	"ts_ls",
	"typst_lsp",
	"marksman",
	"wgsl_analyzer",
}
for _, server in pairs(servers) do
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	-- if server == "denols" then
	-- 	opts.init_options = {
	-- 		importMap = "./import_map.json",
	-- 		config = "./deno.json",
	-- 	}
	-- 	opts.root_dir = util.root_pattern("deno.json", "deno.jsonc")
	-- end

	if server == "pyright" then
		-- pythonPath = "/home/tombh/.rye/py/cpython@3.12.4/bin/python3.12",
		-- venvPath = "/home/tombh/Syncthing/SyncMisc/tbx/wayfire/.venv",
		opts.root_dir = util.root_pattern("pyproject.toml")
		opts.settings = {
			python = {
				pythonPath = "/home/tombh/Syncthing/SyncMisc/tbx/wayfire/.venv/bin/python",
				-- analysis = {
				-- 	autoSearchPaths = true,
				-- 	useLibraryCodeForTypes = true,
				-- 	diagnosticMode = "openFilesOnly",
				-- },
			},
		}
		-- opts.before_init = function(_, config)
		-- 	-- config.settings.python.pythonPath = get_python_path(config.root_dir)
		-- 	config.settings.python.pythonPath = "/home/tombh/.rye/py/cpython@3.12.4/bin/python3.12"
		-- end
	end

	if server == "vuels" then
		opts.settings = {
			css = {},
			emmet = {},
			html = {
				suggest = {},
			},
			javascript = {
				format = {},
			},
			stylusSupremacy = {},
			typescript = {
				format = {},
			},
			vetur = {
				completion = {
					autoImport = false,
					tagCasing = "kebab",
					useScaffoldSnippets = false,
				},
				format = {
					defaultFormatter = {
						js = "none",
						ts = "none",
					},
					defaultFormatterOptions = {},
					scriptInitialIndent = false,
					styleInitialIndent = false,
				},
				useWorkspaceDependencies = false,
				validation = {
					script = false,
					style = true,
					template = true,
				},
			},
		}
	end

	if server == "lua_ls" then
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "describe", "it", "before_each", "after_each" },
				},
			},
		}
		opts.init_options = {
			-- Using null-ls's stylua and luacheck instead
			format = false,
		}
	end

	if server == "rust_analyzer" then
		opts.settings = {
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
						"--all-features",
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

	if server == "stylelint_lsp" then
		opts.settings = {
			stylelintplus = {
				autoFixOnFormat = true,
				autoFixOnSave = true,
			},
		}
		opts.filetypes = { "css", "less", "scss" }
	end

	if server == "typst_lsp" then
		opts.settings = {
			exportPdf = "never", -- Choose onType, onSave or never.
			-- serverPath = "" -- Normally, there is no need to uncomment it.
		}
	end

	require("lspconfig")[server].setup(opts)
end

local null_ls = require("null-ls")
null_ls.setup({
	debug = true,
	sources = {
		-- null_ls.builtins.diagnostics.luacheck,
		-- null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.stylelint,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.sqlfluff.with({
		-- 	extra_args = { "--dialect", "postgres" },
		-- }),
		-- null_ls.builtins.formatting.sqlfluff.with({
		-- 	extra_args = { "--dialect", "postgres" },
		-- }),
	},
	update_in_insert = false,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b._formatting_disabled = false
	vim.notify("Auto-formatting enabled for buffer")
end, {})

vim.api.nvim_create_user_command("FormatDisable", function()
	vim.b._formatting_disabled = true
	vim.notify("Auto-formatting disabled for buffer")
end, {})

-- vim.api.nvim_create_autocmd({ "TextChangedI" }, {
-- 	-- or vim.api.nvim_create_autocmd({"BufNew", "TextChanged", "TextChangedI", "TextChangedP", "TextChangedT"}, {
-- 	callback = function(args)
-- 		vim.diagnostic.disable(args.buf)
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufWrite" }, {
-- 	callback = function(args)
-- 		vim.diagnostic.enable(args.buf)
-- 	end,
-- })
