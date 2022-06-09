local present, cmp_npm = pcall(require, "cmp-npm")

if not present then
    return
end

cmp_npm.setup({
    ignore = {},
    only_semantic_versions = true,
})
