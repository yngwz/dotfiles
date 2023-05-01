-- local reload = require("yngwz.utils.reload")
utils = {}

-- _G.reload = function()
--     reload.all()
--     vim.notify("Nvim config reloaded", vim.log.levels.INFO)
-- end
--
-- _G.P = function(v)
--     print(vim.inspect(v))
--     return v
-- end
--
-- _G.reload_module = function(name)
--     reload.module(name)
-- end

utils.map = function(mode, keys, command, opt)
    local options = { silent = true }

    if opt then
        options = vim.tbl_extend("force", options, opt)
    end

    if type(keys) == "table" then
        for _, keymap in ipairs(keys) do
            utils.map(mode, keymap, command, opt)
        end
        return
    end

    vim.keymap.set(mode, keys, command, opt)
end

utils.close_buffer = function(force)
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_win_hide(0)
        return
    end

    local fileExists = vim.fn.filereadable(vim.fn.expand("%p"))
    local modified = vim.api.nvim_buf_get_option(vim.fn.bufnr(), "modified")

    -- if file doesnt exist & its modified
    if fileExists == 0 and modified then
        print("no file name? add it now!")
        return
    end

    force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

    -- if not force, change to prev buf and then close current
    local close_cmd = force and ":bd!" or ":bp | bd" .. vim.fn.bufnr()
    vim.cmd(close_cmd)
end

utils = utils
