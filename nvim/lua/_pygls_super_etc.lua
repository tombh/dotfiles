vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.py", "*.json" },
	callback = function()
		vim.lsp.start({
			name = "super-glass-lsp-prod",
			cmd = {
				"super-glass-lsp",
				"--logfile",
				vim.env.HOME .. "/logs/super-glass-prod.log",
			},
			root_dir = vim.fs.dirname(vim.fs.find({ "setup.py", "pyproject.toml" }, { upward = true })[1]),
			init_options = {
				configs = {
					markdownlint = {
						enabled = false,
					},
					jqlint = {
						enabled = true,
					},
					fuzzy_buffer_tokens = {
						enabled = false,
					},
					black = {
						enabled = true,
					},
					flake8 = {
						enabled = false,
					},
				},
			},
		})
	end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = { "*.md", "*.json", "*.py", "*.mime" },
-- 	callback = function()
-- 		vim.lsp.start({
-- 			name = "super-glass-lsp-dev",
-- 			cmd = {
-- 				"sh",
-- 				"-c",
-- 				"cd "
-- 					.. vim.env.HOME
-- 					.. "/Workspace/super-glass-lsp && "
-- 					.. "poetry run python super_glass_lsp/main.py "
-- 					-- .. "--app email_client "
-- 					.. "--logfile "
-- 					.. vim.env.HOME
-- 					.. "/logs/super-glass-dev.log",
-- 			},
-- 			root_dir = vim.fs.dirname(vim.fs.find({ "inbox.md" }, { upward = true })[1]),
-- 			init_options = {
-- 				configs = {
-- 					markdownlint = {
-- 						enabled = false,
-- 					},
-- 					jqlint = {
-- 						enabled = false,
-- 					},
-- 					fuzzy_buffer_tokens = {
-- 						enabled = false,
-- 					},
-- 					mypy = {
-- 						enabled = true,
-- 						timeout = 30,
-- 					},
-- 					black = {
-- 						enabled = true,
-- 					},
-- 					flake8 = {
-- 						enabled = false,
-- 					},
-- 				},
-- 			},
-- 		})
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = { "*.txt" },
-- 	callback = function()
-- 		vim.lsp.start({
-- 			name = "pygls-example",
-- 			cmd_cwd = "/home/tombh/Workspace/pygls-example",
-- 			cmd = { "poetry", "run", "python", "main.py" },
-- 			root_dir = vim.fs.dirname(vim.fs.find({ "main.py" }, { upward = true })[1]),
-- 			init_options = {},
-- 		})
-- 	end,
-- })
