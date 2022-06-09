-- TODO Filter out emmet completions that aren't relevant
-- For example: inserting 'a' will show a completiong for <a></a>
--
--LSP protocol does not allow triggering on regex. This trigger list would make it more usable
---- local trigger_characters = {
--     ">",
--     ")",
--     "]",
--     "}",
--
--     "@",
--     "*",
--     "$",
--     "+",
-- }
--
--Turning off emmet for now

local M = {}
local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

M.filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "haml",
    "xml",
    "xsl",
    "pug",
    "slim",
    "sass",
    "stylus",
    "less",
    "sss",
    "hbs",
    "handlebars",
}

return M
