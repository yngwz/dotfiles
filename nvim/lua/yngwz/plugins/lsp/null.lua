local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local completion = null_ls.builtins.completion

local sources = {
    -- webdev
    formatting.prettierd({
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
        },
    }),
    formatting.rustywind,

    -- Lua
    formatting.stylua,
    diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

    -- Markdown
    null_ls.builtins.diagnostics.markdownlint,
}

-- add to a specific server's on_attach,
-- or to a common on_attach callback to enable for all supported filetypes
local on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
       ]])
    end
end

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
})
