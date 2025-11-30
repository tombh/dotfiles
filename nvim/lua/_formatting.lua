vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = function()
		if vim.b._formatting_disabled ~= true then
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 10000,
				-- filter = function(client)
				-- 	-- Never use Typescript LSP to format, rely on Prettier instead
				-- 	return client.name ~= "tsserver"
				-- end,
			})
		end
	end
})

-- Rerun `biome` on `.svelte` files, after all the other fomatters have run. `biome` doesn't support
-- formatting the HTML and CSS blocks, so we let the other formatters do those first.
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.svelte',
	callback = function()
		if vim.b._formatting_disabled ~= true then
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 10000,
				filter = function(client)
					return client.name ~= "svelte"
				end,
			})
		end
	end
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b._formatting_disabled = false
	vim.notify("Auto-formatting enabled for buffer")
end, {})

vim.api.nvim_create_user_command("FormatDisable", function()
	vim.b._formatting_disabled = true
	vim.notify("Auto-formatting disabled for buffer")
end, {})
