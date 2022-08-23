-- n, v, i are mode names

local M = {}

M.general = {
    i = {

        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
        ["<C-e>"] = { "<End>", "壟 end of line" },

        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "  move left" },
        ["<C-l>"] = { "<Right>", " move right" },
        ["<C-j>"] = { "<Down>", " move down" },
        ["<C-k>"] = { "<Up>", " move up" },
    },

    n = {

        -- switch between windows
        ["<C-h>"] = { "<C-w>h", " window left" },
        ["<C-l>"] = { "<C-w>l", " window right" },
        ["<C-j>"] = { "<C-w>j", " window down" },
        ["<C-k>"] = { "<C-w>k", " window up" },

        -- save
        ["<leader>w"] = { "<cmd> w <CR>", "﬚  save file" },

        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

        -- line numbers
        ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
        ["<leader>rn"] = {
            "<cmd> set rnu! <CR>",
            "   toggle relative number",
        },
        -- Search
        ["<Esc>"] = { "<cmd> noh <CR>", "Clear search highlight" },
    },
}

M.bufferline = {

    n = {
        -- new buffer
        ["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

        -- cycle through buffers
        ["<TAB>"] = {
            "<cmd> BufferLineCycleNext <CR>",
            "  cycle next buffer",
        },
        ["<S-Tab>"] = {
            "<cmd> BufferLineCyclePrev <CR>",
            "  cycle prev buffer",
        },

        -- close buffer + hide terminal buffer
        ["<leader>x"] = {
            function()
                utils.close_buffer()
            end,
            "   close buffer",
        },
    },
}

M.comment = {

    -- toggle comment in both modes
    n = {
        ["<leader>/"] = {
            "<cmd> lua require('Comment.api').toggle_current_linewise()<CR>",
            "蘒  toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            "<cmd> lua require('Comment.api').toggle_current_linewise_op(vim.fn.visualmode())<CR>",
            "蘒  toggle comment",
        },
    },
}

M.lspconfig = {
    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "   lsp declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "   lsp definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "   lsp hover",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "   lsp implementation",
        },

        ["<C-k>"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "   lsp signature_help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "   lsp definition type",
        },

        ["<leader>ra"] = {
            function()
                vim.lsp.buf.rename()
            end,
            "   lsp rename",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "   lsp code_action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "   lsp references",
        },

        ["<leader>ge"] = {
            function()
                vim.diagnostic.open_float()
            end,
            "   floating diagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev()
            end,
            "   goto prev",
        },

        ["d]"] = {
            function()
                vim.diagnostic.goto_next()
            end,
            "   goto_next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "   diagnostic setloclist",
        },

        ["<leader>fm"] = {
            function()
                vim.lsp.buf.formatting()
            end,
            "   lsp formatting",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "   add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "   remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "   list workspace folders",
        },
    },
}

M.packer = {
    n = {
        ["<leader>ps"] = {
            "<cmd> PackerSnapSync <CR>",
            "Creates a snapshot then PackerSync",
        },
        ["<leader>pi"] = {
            "<cmd> PackerInstall <CR>",
            "Clean, then install missing plugins",
        },
        ["<leader>pu"] = {
            "<cmd> PackerUpdate <CR>",
            "Clean, then update and install missing plugins",
        },
        ["<leader>pr"] = {
            "<cmd> PackerStatus <CR>",
            "Status report of packages",
        },
    },
}

M.nvimtree = {

    n = {
        -- toggle
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

        -- focus
        ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
    },
}

M.telescope = {
    n = {
        -- find
        ["<leader>ff"] = {
            "<cmd> Telescope find_files <CR>",
            "  find files",
        },
        ["<leader>fa"] = {
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
            "  find all",
        },
        ["<leader>fg"] = {
            "<cmd> Telescope live_grep <CR>",
            "   live grep",
        },
        ["<leader>fb"] = {
            "<cmd> Telescope buffers <CR>",
            "  find buffers",
        },
        ["<leader>fh"] = {
            "<cmd> Telescope help_tags <CR>",
            "  help page",
        },
        ["<leader>fo"] = {
            "<cmd> Telescope oldfiles <CR>",
            "   find oldfiles",
        },
        ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

        -- git
        ["<leader>cm"] = {
            "<cmd> Telescope git_commits <CR>",
            "   git commits",
        },
        ["<leader>gt"] = {
            "<cmd> Telescope git_status <CR>",
            "  git status",
        },

        -- pick a hidden term
    },
}

utils.map("n", "<leader>vr", "<cmd>lua reload() <CR>")

return M
