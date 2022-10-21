local typescript_present, typescript = pcall(require, "typescript")
local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
    return
end

local M = {}

local handlers = require("yngwz.plugins.others").lsp_handlers()

function M.on_attach(client, _)
    client.server_capabilitie.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
end

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local function on_attach(_, _)
    -- set up buffer keymaps, etc.
end

lspconfig.tsserver.setup({
    on_attach = require("yngwz.plugins.lsp.servers.ts_server").on_attach,
    capabilities = require("yngwz.plugins.lsp.servers.ts_server").capabilities,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.tailwindcss.setup({
    capabilities = require("yngwz.plugins.lsp.servers.tailwindcss").capabilities,
    filetypes = require("yngwz.plugins.lsp.servers.tailwindcss").filetypes,
    handlers = handlers,
    init_options = require("yngwz.plugins.lsp.servers.tailwindcss").init_options,
    on_attach = require("yngwz.plugins.lsp.servers.tailwindcss").on_attach,
    settings = require("yngwz.plugins.lsp.servers.tailwindcss").settings,
})

-- lspconfig.eslint.setup({
--     capabilities = capabilities,
--     handlers = handlers,
--     on_attach = require("yngwz.plugins.lsp.servers.eslint").on_attach,
--     settings = require("yngwz.plugins.lsp.servers.eslint").settings,
-- })

lspconfig.jsonls.setup({
    capabilities = capabilities,
    handlers = handlers,
    on_attach = require("yngwz.plugins.lsp.servers.json").on_attach,
    settings = require("yngwz.plugins.lsp.servers.json").settings,
})

lspconfig.sumneko_lua.setup({
    handlers = handlers,
    on_attach = require("yngwz.plugins.lsp.servers.lua").on_attach,
    settings = require("yngwz.plugins.lsp.servers.lua").settings,
})

-- lspconfig.emmet_ls.setup({
--     capabilities = require("yngwz.plugins.lsp.servers.emmet").capabilities,
--     handlers = handlers,
--     on_attach = on_attach,
--     filetypes = require("yngwz.plugins.lsp.servers.emmet").filetypes,
-- })
--
lspconfig.prismals.setup({
    on_attach = on_attach,
    filetypes = require("yngwz.plugins.lsp.servers.prisma").filetypes,
    capabilities = require("yngwz.plugins.lsp.servers.prisma").capabilities,
    settings = require("yngwz.plugins.lsp.servers.prisma").settings,
})

for _, server in ipairs({ "bashls", "cssls", "html", "prismals" }) do
    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
    })
end

return M
