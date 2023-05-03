local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "nvim-lua/plenary.nvim" },
    { "miversen33/import.nvim" },
    { "lewis6991/impatient.nvim" },
    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = ":CatppuccinCompile",
        config = function()
            require("yngwz.plugins.catppuccin")
        end,
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("yngwz.plugins.icons")
        end,
    },

    {
        "feline-nvim/feline.nvim",
        config = function()
            require("yngwz.plugins.feline")
        end,
    },

    {
        "akinsho/bufferline.nvim",
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
        build = ":TSUpdate",
        config = function()
            require("yngwz.plugins.treesitter")
        end,
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "nvim-treesitter/nvim-treesitter-context",
            "RRethy/nvim-treesitter-textsubjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("yngwz.plugins.autoclose").autotag()
                end,
            },
        },
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("yngwz.plugins.vim-illuminate")
        end,
    },
    {
        "m-demare/hlargs.nvim",
        config = function()
            require("yngwz.plugins.hlargs")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("yngwz.plugins.others").gitsigns()
        end,
    },

    -- LSP
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

    -- CMP
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("yngwz.plugins.cmp")
        end,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "ray-x/cmp-treesitter",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-cmdline",
            "David-Kunz/cmp-npm",
            "zbirenbaum/copilot-cmp",
        },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("yngwz.plugins.autoclose").autopairs()
        end,
    },
    { "onsails/lspkind.nvim" },
    {
        "zbirenbaum/copilot.lua",
    },

    -- DAP
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
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
        "numToStr/Comment.nvim",
        module = "Comment",
        keys = { "gc", "gb" },
        config = function()
            require("yngwz.plugins.comment")
        end,
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
        dependencies = { "telescope.nvim" },
        config = function()
            require("yngwz.plugins.notify")
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            require("yngwz.plugins.whichkey")
        end,
    },
    {
        "tpope/vim-surround",
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
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("yngwz.plugins.harpoon")
        end,
    },

    -- Local plugins
    {
        name = "Componentizer",
        dir = "~/Projects/neovim-plugins/Componentizer",
        dev = true,
    },
}

require("lazy").setup(plugins)
