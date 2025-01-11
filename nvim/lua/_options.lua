-- Tabs should be real tabs and be disaplyed as 2 wide
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Don't keep backups.
-- Also is needed for filesystem watchers to detect when we save a file.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Show the current line background
vim.opt.cursorline = true

-- The gutter is always 2-wide, so there's no jarring screen jump when gutters
-- get icons in them.
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 2

-- 24 bit colours
vim.opt.termguicolors = true

-- Don't wrap long lines
vim.opt.wrap = false

--
vim.opt.cursorlineopt = 'screenline' -- TODO: Add to Novim-mode?

-- Various "hidden" chars
vim.opt.fillchars = { eob = ' ', diff = ' ', foldopen = '▾', foldsep = '│', foldclose = '▸' }
vim.list = true
vim.opt.listchars = { tab = '——', eol = '↲', nbsp = '␣', trail = ' ', extends = '⟩', precedes = '⟨' }

-- Why??
vim.opt.hidden = true
vim.opt.ignorecase = true

-- Git signs and word-under-cursor highlight
vim.opt.updatetime = 250

-- Use tmux.nvim's special nvim/tmux pane navigation
vim.g.novim_mode_use_pane_controls = 0
