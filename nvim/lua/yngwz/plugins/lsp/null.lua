local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local completion = null_ls.builtins.completion

local sources = {
    -- webdev
    formatting.prettierd.with({
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "yaml",
            "markdown",
            "graphql",
            "handlebars",
            "json",
            "jsonc",
        },
    }),
    formatting.rustywind,
    diagnostics.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({ "package.json" })
        end,
    }),

    -- Lua
    formatting.stylua,
    diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

    -- Markdown
    null_ls.builtins.diagnostics.markdownlint,
}

-- Formatting
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if
                not vim.api.nvim_buf_is_loaded(bufnr)
                or vim.api.nvim_buf_get_option(bufnr, "modified")
            then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(
                    res,
                    bufnr,
                    client and client.offset_encoding or "utf-16"
                )
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                async_formatting(bufnr)
            end,
        })
    end
end
-- or to a common on_attach callback to enable for all supported filetypes
-- local on_attach = function(client,bufnr)
--     if client.server_capabilities.document_formatting then
--         vim.cmd([[
--             augroup LspFormatting
--                 autocmd! * <buffer>
--                 autocmd BufWritePre <buffer> lua vim.lsp.buf.format({
--                     bufnr = bufnr,
--                     filter = function(client)
--                         return client.name
--                     end
--                 })
--             augroup END
--        ]])
--     end
-- end
--
null_ls.setup({
    debug = true,
    sources = sources,
    on_attach = on_attach,
})
