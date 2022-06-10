local M = {}

local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Settings

local filetypes = {
    "prisma",
}

local settings = {
    prisma = {
        prismaFmtBinPath = "~/.nvm/versions/node/v14.17.1/bin/prisma",
    },
}

M.filetypes = filetypes
M.capabilities = capabilities
M.settings = settings

return M
