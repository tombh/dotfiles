local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

execute("packadd packer.nvim")

local packer = require("packer")
local use = packer.use

-- See: https://github.com/wbthomason/packer.nvim/issues/274
local PACKER_COMPILED_PATH = vim.fn.stdpath("cache") .. "/packer.nvim/packer_compiled.lua"

require("packer").init()

require("packer").startup({
	function()
		use("wbthomason/packer.nvim")

		-- does this need to be loaded first?
		use({
			"tombh/novim-mode",
			branch = "next",
		})

		-- color related stuff
		use("folke/tokyonight.nvim")
		-- Highlights hex codes, etc in files
		use("norcalli/nvim-colorizer.lua")

		-- Auto mangae/install dependencies
		use({
			"williamboman/mason.nvim",
			run = ":MasonUpdate", -- :MasonUpdate updates registry contents
		})
		use({
			"williamboman/mason-lspconfig.nvim",
		})

		-- lsp stuff
		use("nvim-treesitter/nvim-treesitter")
		use("neovim/nvim-lspconfig")
		use("nvimtools/none-ls.nvim")
		use("onsails/lspkind-nvim")
		use("folke/neodev.nvim")

		-- completion stuff
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")
		use("dcampos/nvim-snippy")
		use("dcampos/cmp-snippy")
		use("honza/vim-snippets")

		-- file managing, picker etc
		use("kyazdani42/nvim-web-devicons")
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
		})
		use("nvim-telescope/telescope.nvim")
		use("nvim-lua/popup.nvim")
		use("nvim-telescope/telescope-ui-select.nvim")
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

		-- misc
		-- KDL is a config format that Zellij uses
		use("imsnif/kdl.vim")
		-- use("ojroques/vim-oscyank") -- there's a dedicated Neovim plugin now
		use("nvim-lua/plenary.nvim")
		use("karb94/neoscroll.nvim")
		use("ntpeters/vim-better-whitespace")
		use("dietsche/vim-lastplace")
		use("numToStr/Comment.nvim")
		use("famiu/nvim-reload")
		use({ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} })
		use("Pocco81/TrueZen.nvim")
		use("lewis6991/gitsigns.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use("windwp/nvim-autopairs")
		use("alvan/vim-closetag")
		use("tpope/vim-sleuth")
		use("tzachar/local-highlight.nvim")

		use({
			"folke/noice.nvim",
			event = "VimEnter",
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		})
		use("petertriho/nvim-scrollbar")

		use({ "kaarmu/typst.vim", ft = { "typst" } })
		use({ "isobit/vim-caddyfile" })
	end,
	config = {
		compile_path = PACKER_COMPILED_PATH,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

vim.cmd([[packadd noice.nvim]])

if not vim.g.packer_compiled_loaded and vim.loop.fs_stat(PACKER_COMPILED_PATH) then
	vim.cmd(string.format("source %s", PACKER_COMPILED_PATH))
	vim.g.packer_compiled_loaded = true
end
