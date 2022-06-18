local m = {}

-- TODO can't reload all of my nvim configs. I should be able to do it now that all packages are namespaced.

m.all = function()
    local present, plenary = pcall(require, "plenary")
    if not present then
        print("plenary not present to reload module")
        return true
    end

    for name, _ in pairs(package.loaded) do
        if name:match("^yngwz") then
            plenary.reload.reload_module(name, true)
            require(name)
        end
    end
end

return m
