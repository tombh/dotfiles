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
