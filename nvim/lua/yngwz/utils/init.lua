local reload = require("yngwz.utils.reload")
_G.utils = {}

_G.reload = function()
    reload.all()
    vim.notify("Nvim config reloaded", vim.log.levels.INFO)
end

_G.P = function(v)
    print(vim.inspect(v))
    return v
end

_G.reload_module = function(name)
    reload.module(name)
end

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

-- load plugin after entering vim ui
utils.packer_lazy_load = function(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            require("packer").loader(plugin)
        end, timer)
    end
end

local function print_table(node)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
                if string.find(output_str, "}", output_str:len()) then
                    output_str = output_str .. ",\n"
                elseif
                    not (string.find(output_str, "\n", output_str:len()))
                then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if type(k) == "number" or type(k) == "boolean" then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if type(v) == "number" or type(v) == "boolean" then
                    output_str = output_str
                        .. string.rep("\t", depth)
                        .. key
                        .. " = "
                        .. tostring(v)
                elseif type(v) == "table" then
                    output_str = output_str
                        .. string.rep("\t", depth)
                        .. key
                        .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str
                        .. string.rep("\t", depth)
                        .. key
                        .. " = '"
                        .. tostring(v)
                        .. "'"
                end

                if cur_index == size then
                    output_str = output_str
                        .. "\n"
                        .. string.rep("\t", depth - 1)
                        .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if cur_index == size then
                    output_str = output_str
                        .. "\n"
                        .. string.rep("\t", depth - 1)
                        .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if size == 0 then
            output_str = output_str
                .. "\n"
                .. string.rep("\t", depth - 1)
                .. "}"
        end

        if #stack > 0 then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)

    print(output_str)
end
utils.print_table = print_table
