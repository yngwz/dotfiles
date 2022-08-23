local present, packer = pcall(require, "yngwz.plugins.packerInit")

if not present then
    error("Packer couldn't load: " .. "\n\n" .. packer)
    return false
end

local plugins = {
    { "nvim-lua/plenary.nvim" },
    { "lewis6991/impatient.nvim" },
    { "wbthomason/packer.nvim", event = "VimEnter" },
    -- Theme
    {
        "catppuccin/nvim",
        as = "catppuccin",
        after = "packer.nvim",
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
        "m-demare/hlargs.nvim",
        config = function()
            require("hlargs").setup()
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

    {
        "williamboman/nvim-lsp-installer",
        opt = true,
        setup = function()
            utils.packer_lazy_load("nvim-lsp-installer")
            -- reload the current file so lsp actually starts for it
            vim.defer_fn(function()
                vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
            end, 0)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        after = "nvim-lsp-installer",
        module = "lspconfig",
        config = function()
            require("yngwz.plugins.lsp.installer")
            require("yngwz.plugins.lsp.config")
        end,
    },
    {
        "jose-elias-alvarez/typescript.nvim",
        after = "nvim-lsp-installer",
    },
    {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("yngwz.plugins.others").signature()
        end,
    },
    {
        "andymass/vim-matchup",
        opt = true,
        setup = function()
            utils.packer_lazy_load("vim-matchup")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("yngwz.plugins.lsp.null")
        end,
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertCharPre",
        config = function()
            require("yngwz.plugins.others").better_escape()
        end,
    },

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
        "David-Kunz/cmp-npm",
        after = "cmp-path",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("yngwz.plugins.cmp-npm")
        end,
    },
    -- Misc
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
}

return packer.startup(function(use)
    for _, v in pairs(plugins) do
        use(v)
    end
end)
