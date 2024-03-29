local M = {}

M.better_escape = function()
    local present, escape = pcall(require, "better_escape")

    if not present then
        return
    end

    local options = {
        mapping = { "jk" }, -- a table with mappings to use
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>",
    }

    escape.setup(options)
end

M.blankline = function()
    local present, blankline = pcall(require, "indent_blankline")
    if not present then
        return
    end

    local options = {
        indentLine_enabled = 0,
        char = "▏",
        filetype_exclude = {
            "help",
            "terminal",
            "alpha",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "lsp-installer",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
    }

    blankline.setup(options)
end

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")

    if not present then
        return
    end

    local options = {
        filetypes = {
            "*",
        },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

            -- Available modes: foreground, background
            mode = "background", -- Set the display mode.
        },
    }

    colorizer.setup(options)
    vim.cmd("ColorizerReloadAllBuffers")
end

M.luasnip = function()
    local present, luasnip = pcall(require, "luasnip")

    if not present then
        return
    end

    luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
    })

    require("luasnip.loaders.from_vscode").lazy_load()
end

M.signature = function()
    local present, lsp_signature = pcall(require, "lsp_signature")

    if not present then
        return
    end

    local options = {
        bind = true,
        doc_lines = 0,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hint_prefix = " ",
        hint_scheme = "String",
        hi_parameter = "Search",
        max_height = 22,
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = {
            border = "single", -- double, single, shadow, none
        },
        zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
        padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    }

    lsp_signature.setup(options)
end

M.lsp_handlers = function()
    local function lspSymbol(name, icon)
        local hl = "DiagnosticSign" .. name
        vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
    end

    lspSymbol("Error", "")
    lspSymbol("Info", "")
    lspSymbol("Hint", "")
    lspSymbol("Warn", "")

    vim.diagnostic.config({
        -- virtual_text = {
        --     prefix = "",
        -- },
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
    })

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(
            vim.lsp.handlers.hover,
            {
                border = "single",
            }
        )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "single",
        }
    )

    vim.lsp.handlers["eslint"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
        }
    )

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level)
        if msg:match("exit code") then
            return
        end
        if log_level == vim.log.levels.ERROR then
            vim.api.nvim_err_writeln(msg)
        else
            vim.api.nvim_echo({ { msg } }, true, {})
        end
    end
end

M.gitsigns = function()
    local present, gitsigns = pcall(require, "gitsigns")

    if not present then
        return
    end

    gitsigns.setup({
        signs = {
            add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
            change = {
                hl = "DiffChange",
                text = "│",
                numhl = "GitSignsChangeNr",
            },
            delete = {
                hl = "DiffDelete",
                text = "",
                numhl = "GitSignsDeleteNr",
            },
            topdelete = {
                hl = "DiffDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
            },
            changedelete = {
                hl = "DiffChangeDelete",
                text = "~",
                numhl = "GitSignsChangeNr",
            },
        },
    })
end

return M
