-- Autocommands helper.
-- Modified from:
--   https://www.reddit.com/r/neovim/comments/t6sobd/smol_wrapper_around_lua_autocmd_api/
--
-- Example usage:
--
-- require("autocommands")("HighlightReferences")(function(autocmd)
--   autocmd("CursorHold", { buffer = bufnr }, function()
--     vim.lsp.buf.document_highlight()
--   end)
-- )
--
-- @param group The augroup name.
local au = function(group)
	vim.api.nvim_create_augroup(group, { clear = true })

	-- Return a closure.
	return function(autocmds)
		-- @param event The autocommand event.
		-- @param opts A table of options to pass to vim.api.nvim_create_autocmd
		-- @param command A string or function reference.
		autocmds(function(event, opts, command)
			opts.group = group

			-- Implemented as of https://github.com/neovim/neovim/pull/17698
			if opts.buffer ~= nil then
				vim.api.nvim_clear_autocmds({ buffer = opts.buffer, group = group })
			end

			if type(command) == "function" then
				opts.callback = command
			else
				opts.command = command
			end

			vim.api.nvim_create_autocmd(event, opts)
		end)
	end
end

au("Startup")(function(autocmd)
	autocmd("VimEnter", { pattern = "*" }, function()
		if vim.bo.filetype == "gitcommit" then
			return
		end
		if vim.bo.filetype ~= "" then
			if vim.fn.winwidth('%') > 120 then
				vim.api.nvim_command("NeoTreeShow")
			end
		else
			if vim.fn.winwidth('%') > 120 then
				-- Doesn't look like there's a file, so choose one
				-- TODO: But files without extensions, for example, don't report a filetype 🤔
				vim.api.nvim_command("NeoTreeFocus")
			end
		end
	end)

	-- Save indents as real tabs, but don't display as crazy long 8-width indents
	autocmd("BufRead,BufNew", { pattern = "*" }, function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
	end)
end)
