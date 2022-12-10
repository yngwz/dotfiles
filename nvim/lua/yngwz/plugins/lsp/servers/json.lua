local M = {}

M.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.document_range_formatting = true

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

M.settings = {
    json = {
        schemas = {
            {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
            },
            {
                fileMatch = { "tsconfig*.json" },
                url = "https://json.schemastore.org/tsconfig.json",
            },
            {
                fileMatch = {
                    ".prettierrc",
                    ".prettierrc.json",
                    "prettier.config.json",
                },
                url = "https://json.schemastore.org/prettierrc.json",
            },
            {
                fileMatch = { ".eslintrc", ".eslintrc.json" },
                url = "https://json.schemastore.org/eslintrc.json",
            },
            {
                fileMatch = {
                    ".babelrc",
                    ".babelrc.json",
                    "babel.config.json",
                },
                url = "https://json.schemastore.org/babelrc.json",
            },
            {
                fileMatch = { "lerna.json" },
                url = "https://json.schemastore.org/lerna.json",
            },
            {
                fileMatch = { "now.json", "vercel.json" },
                url = "https://json.schemastore.org/now.json",
            },
            {
                fileMatch = { "ecosystem.json" },
                url = "https://json.schemastore.org/pm2-ecosystem.json",
            },
            {
                fileMatch = { "turbo.json" },
                url = "https://turborepo.org/schema.json",
            },
            {
                fileMatch = { "app.json" },
                url = "https://json.schemastore.org/expo-46.0.0.json",
            },
            {
                fileMatch = { "deno.json" },
                url = "https://json.schemastore.org/deno.json",
            },
        },
    },
}

return M
