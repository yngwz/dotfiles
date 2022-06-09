local present, luasnip = pcall(require, "luasnip")

if not present then
    return
end

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

-- load snippets
require("snippets.react")
require("snippets.lua")

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

-- <c-k> jump to the next expansion or field
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- <c-j> jump to the previous item
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- <c-l> selecting within a list of options
vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })

vim.keymap.set(
    "n",
    "<leader><leader>s",
    "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>"
)
