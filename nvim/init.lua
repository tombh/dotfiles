require("_rocks")

local tmp = vim.g.rocks_nvim
tmp._log_level = vim.log.levels.DEBUG
vim.g.rocks_nvim = tmp

require("_utils")
require("_colours")

require("_keymaps")
require("_neo-tree")
require("_tmux")
require("_lspconfig")
require("_noice")
require("_gitsigns")
require("_blink")
require("_status_line")
require("_options")
require("_formatting")
require("_scrollbar")
require("_telescope")
require("_misc")

require('local-highlight').setup({ insert_mode = true })
require('nvim-autopairs').setup()
vim.cmd.packadd("novim-mode")
