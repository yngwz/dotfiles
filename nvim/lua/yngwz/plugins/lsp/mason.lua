local M = {}

M.mason = function()
    local m_present, mason = pcall(require, "mason")

    if not m_present then
        return
    end
    mason.setup({})
end

M.masonConfig = function()
    local mc_present, masonConfig = pcall(require, "mason-lspconfig")

    if not mc_present then
        return
    end

    masonConfig.setup({})
end

return M
