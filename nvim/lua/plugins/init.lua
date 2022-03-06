local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */plugins/init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("MunifTanjim/nui.nvim")
	use({ "windwp/nvim-autopairs", after = { "nvim-treesitter", "nvim-cmp" } })
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
	use("folke/which-key.nvim")
	use("numToStr/Comment.nvim")
	use("nvim-lua/popup.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("akinsho/toggleterm.nvim")
	use("feline-nvim/feline.nvim")
	use("norcalli/nvim-colorizer.lua")

	-- File explorer
	use("nvim-neo-tree/neo-tree.nvim")

	-- Colerchemes
	use({ "catppuccin/nvim", as = "catppuccin" })

	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", after = "friendly-snippets" }) -- The completion plugin
	use({ "hrsh7th/cmp-nvim-lua", after = "LuaSnip" }) -- path completions
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "cmp-buffer" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", after = "cmp-path" }) -- cmdline completions
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp" }) --snippet engine
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }) -- snippet completions

	-- Language server (LSP)
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", after = { "nvim-treesitter" } })

	-- Comments
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- git
	use("lewis6991/gitsigns.nvim")
end)
