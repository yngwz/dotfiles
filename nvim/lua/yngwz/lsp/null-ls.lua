import(
    { "mason-null-ls", "null-ls", "mason-null-ls.automatic_setup" },
    function(modules)
        local mason_null_ls = modules["mason-null-ls"]
        local mason_automatic_setup = modules["mason-null-ls.automatic_setup"]
        local null_ls = modules["null-ls"]

        mason_null_ls.setup({
            ensure_installed = {
                "stylua",
                "prettierd",
                "rustywind",
                "black",
                "isort",
                "flake8",
            },
        })

        mason_null_ls.setup_handlers({
            function(source_name, methods)
                -- all sources with no handler get passed here
                -- Keep original functionality of `automatic_setup = true`
                mason_automatic_setup(source_name, methods)
            end,
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
    end
)
