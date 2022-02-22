-- aliases
opt = vim.opt  -- global
g = vim.g      -- global for let options
wo = vim.wo    -- window local
bo = vim.bo    -- buffer local
fn = vim.fn    -- access vim functions
cmd = vim.cmd  -- vim commands
api = vim.api

local model = {}

-- map helper
function model.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return model
