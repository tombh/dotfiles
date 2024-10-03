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
	autocmd("UIEnter", { pattern = "*" }, function()
		if vim.bo.filetype == "gitcommit" then
			return
		end

		-- The `vim.schedule` gives neo-tree a moment to set itself up to not be identified as
		-- a normal text file.
		if vim.bo.filetype ~= "" then
			if vim.fn.winwidth("%") > 120 then
				vim.schedule(function()
					vim.api.nvim_command("Neotree show")
				end)
			end
		else
			if vim.fn.winwidth("%") > 120 then
				-- Doesn't look like there's a file, so choose one
				-- TODO: But files without extensions, for example, don't report a filetype 🤔
				vim.schedule(function()
					vim.api.nvim_command("Neotree focus")
				end)
			end
		end
	end)

	autocmd("FocusGained", { pattern = "*" }, function()
		require("neo-tree.sources.manager").refresh("filesystem")
		require("neo-tree.events").fire_event("git_event")
	end)

	-- Save indents as real tabs, but don't display as crazy long 8-width indents
	-- Though defers to vim-sleuth first
	autocmd("BufRead", { pattern = "*" }, function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
	end)

	autocmd("BufWritePre", { pattern = "*" }, function()
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
	end)

	autocmd("BufEnter", { pattern = "*" }, function()
		if vim.bo.filetype ~= "neo-tree" then
			vim.api.nvim_command("EnableWhitespace")
		end
	end)

	autocmd("BufLeave", { pattern = "*" }, function()
		vim.api.nvim_command("DisableWhitespace")
	end)
end)
