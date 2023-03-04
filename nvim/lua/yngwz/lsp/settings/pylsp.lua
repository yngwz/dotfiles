local status, lspconfig_util = pcall(require, "lspconfig.util")

if not status then
    print("no eslint info")
    return
end

return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { "E501" },
                },
            },
        },
    },
}
