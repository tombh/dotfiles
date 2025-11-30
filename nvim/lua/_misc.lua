-- Remember cursor position
-- Thanks to: https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86
vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
		local not_commit = vim.b[args.buf].filetype ~= 'commit'

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = "*.html",
	callback = function()
		vim.cmd([[set filetype=html]])
	end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = "*.Containerfile",
	callback = function()
		vim.cmd([[set filetype=dockerfile]])
	end,
})


-- Try to keep the current line in the middle of the screen.
_G.cursor_last_position = vim.api.nvim_win_get_cursor(0)
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		if vim.bo[bufnr].modifiable == false then
			return
		end

		local mode = vim.fn.mode()
		if not mode:match("^i") then
			return
		end

		local position = vim.api.nvim_win_get_cursor(0)
		local row_delta = math.abs(position[1] - _G.cursor_last_position[1])

		if row_delta > 5 then
			vim.cmd("normal! zz")
		end

		_G.cursor_last_position = position
	end
})
