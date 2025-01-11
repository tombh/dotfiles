vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = function()
		if vim.b._formatting_disabled ~= true then
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 10000,
				filter = function(client)
					-- Never use Typescript LSP to format, rely on Prettier instead
					return client.name ~= "tsserver"
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
