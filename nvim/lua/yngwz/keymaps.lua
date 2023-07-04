-- n, v, i are mode names

local M = {}
-- stylua: ignore start
local savePaste = "\"_dP" --stylelua removes "\"
-- stylua: ignore end

M.general = {
    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
        ["<C-e>"] = { "<End>", "壟 end of line" },
    },
    n = {
        -- switch between windows
        ["<C-h>"] = { "<C-w>h", " window left" },
        ["<C-l>"] = { "<C-w>l", " window right" },
        ["<C-j>"] = { "<C-w>j", " window down" },
        ["<C-k>"] = { "<C-w>k", " window up" },

        -- Delete & save the paste register
        ["<leader>p"] = { savePaste, "Delete & save the paste register" },

        -- save
        ["<leader>w"] = { "<cmd> w <CR>", "﬚  save file" },

        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

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

M.trouble = {
    n = {
        ["<leader>tt"] = { "<cmd> TroubleToggle <CR>", "Toggle Trouble" },
        ["<leader>tw"] = {
            "<cmd> TroubleToggle workspace_diagnostics <CR>",
            "Trouble Workspace Diagnostics",
        },
        ["<leader>td"] = {
            "<cmd> TroubleToggle document_diagnostics<CR>",
            "Trouble Document Diagnostics",
        },
        ["<leader>tl"] = {
            "<cmd> TroubleToggle loclist<CR>",
            "Trouble loclist",
        },
        ["<leader>ty"] = {
            "<cmd> TroubleToggle quickfix<CR>",
            "Trouble quickfix",
        },
        ["<leader>gR"] = {
            "<cmd> TroubleToggle lsp_references<CR>",
            "LSP References",
        },
    },
}

M.DAP = {
    n = {
        ["<F5>"] = { '<cmd>lua require("dap").continue()<CR>', "Continue" },
        ["<F3>"] = { '<cmd>lua require("dap").step_over()<CR>', "Step over" },
        ["<F2>"] = { '<cmd>lua require("dap").step_into()<CR>', "Step into" },
        ["<F12>"] = { '<cmd>lua require("dap").step_out()<CR>', "Step out" },
        ["<leader>b"] = {
            '<cmd>lua require("dap").toggle_breakpoint()<CR>',
            "Toggle breakpoint",
        },
        ["<leader>B"] = {
            '<cmd>lua require("dap")set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
            "Conditional breakpoint",
        },
        ["<leader>lp"] = {
            '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
            "Log point message",
        },
        ["<leader>dr"] = {
            '<cmd>lua require("dap").repl.open<CR>',
            "Open REPL",
        },
        ["<leader>do"] = {
            '<cmd>lua require("dapui").open()',
            "Open DAP ui",
        },
        ["<leader>dc"] = {
            '<cmd>lua require("dapui").close()',
            "Close DAP UI",
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

        ["<leader>rn"] = {
            function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end,
            "  rename",
        },

        ["<leader>ca"] = {
            "<cmd>CodeActionMenu<cr>",
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

        ["<leader>gm"] = {
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

M.harpoon = {
    n = {
        ["<leader>fm"] = {
            "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
            "Marked files",
        },
        ["<leader>mm"] = {
            "<cmd>lua require('harpoon.mark').add_file()<cr>",
            "Mark file",
        },
        ["<leader>m1"] = {
            "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
            "Mark file",
        },
        ["<leader>m2"] = {
            "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
            "Mark file",
        },
        ["<leader>m3"] = {
            "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
            "Mark file",
        },
        ["<leader>m4"] = {
            "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
            "Mark file",
        },
        ["<leader>m5"] = {
            "<cmd>lua require('harpoon.ui').nav_file(5)<cr>",
            "Mark file",
        },
        ["<leader>m6"] = {
            "<cmd>lua require('harpoon.ui').nav_file(6)<cr>",
            "Mark file",
        },
        ["<leader>ml"] = {
            "<cmd>lua require('harpoon.ui').nav_next()<cr>",
            "Mark file",
        },
        ["<leader>mh"] = {
            "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
            "Mark file",
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

return M
