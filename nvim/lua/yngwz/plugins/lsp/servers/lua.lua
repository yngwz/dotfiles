local on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
end

local settings = {
    Lua = {
        diagnostics = {
            globals = { "vim", "utils" },
        },
    },
}

local M = {}

M.settings = settings
M.on_attach = on_attach

return M
