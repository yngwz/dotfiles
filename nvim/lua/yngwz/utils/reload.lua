local m = {}

-- TODO can't reload all of my nvim configs. I should be able to do it now that all packages are namespaced.

m.all = function()
    local present, plenary = pcall(require, "plenary")
    if not present then
        print("plenary not present to reload module")
        return true
    end

    plenary.reload.reload_module("yngwz", true)
    dofile(vim.env.MYVIMRC)
end

m.module = function(name)
    local present, plenary = pcall(require, "plenary")
    if not present then
        print("plenary not present to reload module")
        return true
    end

    plenary.reload.reload_module(name)
    return require(name)
end

return m
