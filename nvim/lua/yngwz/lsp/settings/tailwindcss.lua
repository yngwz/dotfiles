local status, lspconfig_util = pcall(require, "lspconfig.util")

if not status then
    return
end

print("LSP: TailwindCSS")

return {
    root_dir = lspconfig_util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        ".git"
    ),
}
