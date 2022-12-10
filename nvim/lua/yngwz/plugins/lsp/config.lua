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
    local active_clients = vim.lsp.get_active_clients()

    -- Prevent conflict between denols tsserver
    if client.name == "denols" then
        for _, client_ in pairs(active_clients) do
            -- stop tsserver if denols is already active
            if client_.name == "tsserver" then
                client_.stop()
            end
        end
    elseif client.name == "tsserver" then
        for _, client_ in pairs(active_clients) do
            -- prevent tsserver from starting if denols is already active
            if client_.name == "denols" then
                client.stop()
            end
        end
    end
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

typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = require("yngwz.plugins.lsp.servers.ts_server").on_attach,
        capabilities = require("yngwz.plugins.lsp.servers.ts_server").capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
        root_dir = lspconfig.util.root_pattern(
            "package.json",
            "tsconfig.json",
            "gulpfile.js",
            "node_modules"
        ),
    },
})

-- lspconfig.tsserver.setup({})

lspconfig.tailwindcss.setup({
    capabilities = require("yngwz.plugins.lsp.servers.tailwindcss").capabilities,
    filetypes = require("yngwz.plugins.lsp.servers.tailwindcss").filetypes,
    handlers = handlers,
    init_options = require("yngwz.plugins.lsp.servers.tailwindcss").init_options,
    on_attach = require("yngwz.plugins.lsp.servers.tailwindcss").on_attach,
    settings = require("yngwz.plugins.lsp.servers.tailwindcss").settings,
    -- root_dir = lspconfig.util.root_pattern("package.json"),
})

lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})

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
