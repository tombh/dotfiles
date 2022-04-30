vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	init_options = {
		lint = true,
	},
	underline = true,
	virtual_text = {
		spacing = 2,
	},
	update_in_insert = true,
	signs = true,
})

local function on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("i", "<M-D>", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("i", "<M-d>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("i", "<M-?>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("i", "<M-I>", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("i", "<M-S>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("i", "<M-e>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("i", "<M-T>", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("i", "<M-R>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("i", "<M-y>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("i", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	-- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	-- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server.name == "denols" then
		opts.init_options = {
			importMap = "./import_map.json",
			config = "./deno.json",
		}
	end

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		}
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- replace the default lsp diagnostic letters with prettier symbols
local function lspSymbol(name, icon)
	vim.fn.sign_define(
		"DiagnosticSign" .. name,
		{
			text = icon .. " ",
			numhl = "DiagnosticDefault" .. name,
			texthl = "DiagnosticDefault" .. name
		}
	)
end
lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warn", "")
lspSymbol("Warning", "")

--vim.lsp.set_log_level("debug")
