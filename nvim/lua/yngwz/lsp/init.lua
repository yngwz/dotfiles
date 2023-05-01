require("yngwz.lsp.config")
require("yngwz.lsp.fidget")
require("yngwz.lsp.signature")
require("yngwz.lsp.inc-rename")
require("yngwz.lsp.lightbulb")
require("yngwz.lsp.trouble")
require("yngwz.lsp.barbecue")

local mason = require("mason") 
local masonLspConfig = require("mason-lspconfig") 
local cmpLsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")


        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        masonLspConfig.setup({
            ensure_installed = {
                "jsonls",
                "tsserver",
                "eslint",
                "prismals",
                "tailwindcss",
                "html",
                "cssls",
                "astro",
                "yamlls",
                "taplo",
                "marksman",
                "dockerls",
                "volar",
                "rust_analyzer",
            },
        })

        local opts = {
            capabilities = cmpLsp.default_capabilities(),
            on_attach = require("yngwz.lsp.on_attach").on_attach,
        }


        local typescript = require("typescript")

        masonLspConfig.setup_handlers({
            function(server_name)
                local has_custom_opts, custom_opts =
                    pcall(require, "yngwz.lsp.settings." .. server_name)

                local server_opts = opts

                if has_custom_opts then
                    server_opts =
                        vim.tbl_deep_extend("force", custom_opts, opts)
                end

                lspconfig[server_name].setup(server_opts)
            end,
            ["tsserver"] = function()
                    typescript.setup({
                        server = opts,
                    })
            end,
        })

        require("yngwz.lsp.null-ls")
