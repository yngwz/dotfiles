local status, lspconfig_util = pcall(require, "lspconfig.util")

if not status then
    return
end

return {
    root_dir = lspconfig_util.root_pattern("deno.json", "deno.jsonc"),
}
