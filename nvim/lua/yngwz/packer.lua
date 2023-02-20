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
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

local plugins = {
    { "nvim-lua/plenary.nvim" },
    { "miversen33/import.nvim" },
    { "lewis6991/impatient.nvim" },
    { "wbthomason/packer.nvim", event = "VimEnter" },
    -- Theme
    {
        "catppuccin/nvim",
        as = "catppuccin",
        after = "packer.nvim",
        run = ":CatppuccinCompile",
        config = function()
            require("yngwz.plugins.catppuccin")
        end,
    },
    {
        "kyazdani42/nvim-web-devicons",
        after = "catppuccin",
        config = function()
            require("yngwz.plugins.icons")
        end,
    },

    {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = function()
            require("yngwz.plugins.feline")
        end,
    },

    {
        "akinsho/bufferline.nvim",
        after = "nvim-web-devicons",
        config = function()
            require("yngwz.plugins.bufferline")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require("yngwz.plugins.others").blankline()
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufRead" },
        config = function()
            require("yngwz.plugins.others").colorizer()
        end,
    },

    --Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile" },
        run = ":TSUpdate",
        config = function()
            require("yngwz.plugins.treesitter")
        end,
    },
    {
        "nvim-treesitter/playground",
        after = { "nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = { "nvim-treesitter" },
    },
    { "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } },
    {
        "p00f/nvim-ts-rainbow",
        after = { "nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = { "nvim-treesitter" },
    },
    {
        "RRethy/vim-illuminate",
        after = { "nvim-treesitter" },
        config = function()
            require("yngwz.plugins.vim-illuminate")
        end,
    },
    {
        "m-demare/hlargs.nvim",
        after = { "nvim-treesitter" },
        config = function()
            require("yngwz.plugins.hlargs")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opt = true,
        config = function()
            require("yngwz.plugins.others").gitsigns()
        end,
        setup = function()
            utils.packer_lazy_load("gitsigns.nvim")
        end,
    },

    -- LSP
    -- {
    --     "williamboman/mason.nvim",
    --     config = function()
    --         require("yngwz.plugins.lsp.mason").mason()
    --     end,
    -- },
    -- {
    --     "williamboman/mason-lspconfig.nvim",
    --     after = "mason.nvim",
    --     config = function()
    --         require("yngwz.plugins.lsp.mason").masonConfig()
    --     end,
    -- },
    -- {
    --     "neovim/nvim-lspconfig",
    --     after = "mason-lspconfig.nvim",
    --     config = function()
    --         require("yngwz.plugins.lsp.config")
    --     end,
    -- },
    -- {
    --     "jose-elias-alvarez/typescript.nvim",
    -- },
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     after = "nvim-lspconfig",
    --     config = function()
    --         require("yngwz.plugins.others").signature()
    --     end,
    -- },
    -- {
    --     "glepnir/lspsaga.nvim",
    --     after = "nvim-lspconfig",
    -- },
    --
    -- -- {
    -- --     "andymass/vim-matchup",
    -- --     opt = true,
    -- -- },
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     after = "nvim-lspconfig",
    --     requires = { "nvim-lua/plenary.nvim" },
    --     config = function()
    --         require("yngwz.plugins.lsp.null")
    --     end,
    -- },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "b0o/SchemaStore.nvim" },
    { "jose-elias-alvarez/typescript.nvim" },
    { "simrat39/symbols-outline.nvim" },
    { "j-hui/fidget.nvim" },
    { "ray-x/lsp_signature.nvim" },
    { "smjonas/inc-rename.nvim" },
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
    },
    { "kosayoda/nvim-lightbulb" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "jayp0521/mason-null-ls.nvim" },
    { "gpanders/editorconfig.nvim" },
    { "folke/trouble.nvim" },
    { "smiteshp/nvim-navic" },
    { "utilyre/barbecue.nvim" },
    { "simrat39/rust-tools.nvim" },

    -- CMP
    {
        "rafamadriz/friendly-snippets",
        module = "cmp_nvim_lsp",
        event = "InsertEnter",
    },
    {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        before = "nvim-cmp",
        config = function()
            require("yngwz.plugins.luasnip")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        config = function()
            require("yngwz.plugins.cmp")
        end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip",
    },
    {
        "hrsh7th/cmp-nvim-lua",
        after = "cmp_luasnip",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        after = "cmp-nvim-lua",
    },
    {
        "hrsh7th/cmp-buffer",
        after = "cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-path",
        after = "cmp-buffer",
    },
    {
        "ray-x/cmp-treesitter",
        after = "cmp-path",
    },
    { "hrsh7th/cmp-cmdline", after = "cmp-path" },
    { "hrsh7th/cmp-calc", after = "cmp-cmdline" },
    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    {
        "David-Kunz/cmp-npm",
        after = "cmp-path",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("yngwz.plugins.cmp-npm")
        end,
    },

    -- DAP
    {
        "mfussenegger/nvim-dap",
        requires = {
            "jayp0521/mason-nvim-dap.nvim",
        },
        config = function()
            require("yngwz.plugins.dap")
        end,
    },
    {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npm run compile",
    },
    { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } },
    {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
    },

    -- Misc
    {
        "max397574/better-escape.nvim",
        event = "InsertCharPre",
        config = function()
            require("yngwz.plugins.others").better_escape()
        end,
    },
    {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("yngwz.plugins.autoclose").autopairs()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
        config = function()
            require("yngwz.plugins.autoclose").autotag()
        end,
    },
    {
        "numToStr/Comment.nvim",
        module = "Comment",
        keys = { "gc", "gb" },
        config = function()
            require("yngwz.plugins.comment")
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
    },
    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("yngwz.plugins.nvimtree")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require("yngwz.plugins.telescope")
        end,
    },
    {
        "rcarriga/nvim-notify",
        after = "telescope.nvim",
        config = function()
            require("yngwz.plugins.notify")
        end,
    },
    {
        "folke/which-key.nvim",
        opt = true,
        setup = function()
            utils.packer_lazy_load("which-key.nvim")
        end,
        config = function()
            require("yngwz.plugins.whichkey")
        end,
    },
    {
        "tpope/vim-surround",
        opt = true,
        setup = function()
            utils.packer_lazy_load("vim-surround")
        end,
    },
    {
        "nmac427/guess-indent.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("yngwz.plugins.guess-indent")
        end,
    },

    -- UI
    {
        "stevearc/dressing.nvim",
    },
    {
        "tpope/vim-repeat",
    },
    {
        "tpope/vim-obsession",
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "MaxMEllon/vim-jsx-pretty",
    },
    {
        "ThePrimeagen/vim-be-good",
    },
}

return packer.startup(function(use)
    for _, v in pairs(plugins) do
        use(v)
    end
end)
