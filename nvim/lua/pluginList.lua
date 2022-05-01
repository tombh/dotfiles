local packer = require("packer")
local use = packer.use

return require("packer").startup({
	function()
		use("wbthomason/packer.nvim")

		-- does this need to be loaded first?
		use("tombh/novim-mode")

		-- color related stuff
		use("projekt0n/github-nvim-theme")
		use("norcalli/nvim-colorizer.lua")

		-- lsp stuff
		use("nvim-treesitter/nvim-treesitter")
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use("jose-elias-alvarez/null-ls.nvim")
		use("onsails/lspkind-nvim")

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
		use("ryanoasis/vim-devicons")
		use {
			"nvim-neo-tree/neo-tree.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			}
		}
		use("nvim-telescope/telescope.nvim")
		use("nvim-lua/popup.nvim")
		use("nvim-telescope/telescope-ui-select.nvim")

		-- misc
		use("ojroques/vim-oscyank")
		use("sbdchd/neoformat")
		use("nvim-lua/plenary.nvim")
		use("tweekmonster/startuptime.vim")
		use("907th/vim-auto-save")
		use("karb94/neoscroll.nvim")
		use("folke/which-key.nvim")
		use("ntpeters/vim-better-whitespace")
		use("dietsche/vim-lastplace")
		use("numToStr/Comment.nvim")
		use("famiu/bufdelete.nvim")
		use("famiu/nvim-reload")
		use("lukas-reineke/indent-blankline.nvim")
		use("tpope/vim-fugitive")
		use("Pocco81/TrueZen.nvim")
		use("lewis6991/gitsigns.nvim")
		use("windwp/windline.nvim")
		use("windwp/nvim-autopairs")
		use("alvan/vim-closetag")
		use("rcarriga/nvim-notify")

	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
