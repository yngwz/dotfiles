local status, lspconfig_util = pcall(require, "lspconfig.util")

if not status then
    print("no eslint info")
    return
end

return {
    root_dir = lspconfig_util.find_git_ancestor,
}
