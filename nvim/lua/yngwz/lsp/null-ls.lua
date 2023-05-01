
        local mason_null_ls = require("mason-null-ls")
        local mason_automatic_setup = require("mason-null-ls.automatic_setup")
        local null_ls = require("null-ls")


        mason_null_ls.setup({
            ensure_installed = {
                "stylua",
                "prettierd",
                "rustywind",
                "black",
                "isort",
                "flake8",
            },
            automatic_setup = true,
            handlers = {
                                prettierd = function()
                null_ls.register(null_ls.builtins.formatting.prettierd)
            end,
            stylua = function()
                null_ls.register(null_ls.builtins.formatting.stylua)
            end,
            flake8 = function()
                null_ls.register(null_ls.builtins.diagnostics.flake8.with({
                    args = { "--ignore=E501" },
                }))
            end,

            }
        })


        -- will setup any installed and configured sources above
        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
