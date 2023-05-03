local cmp_present, cmp = pcall(require, "cmp")
if not cmp_present then
    return
end

local cmp_window = require("cmp.utils.window")

local snip_present, lua_snip = pcall(require, "luasnip")
if not snip_present then
    return
end

local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menuone,noselect"

local has_copilot, copilot_cmp = pcall(require, "copilot_cmp.comparators")

-- Utils
local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
                .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
                :match("^%s*$")
            == nil
end

-- Setup
function cmp_window:has_scrollbar()
    return true
end

local window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
}

local snippet = {
    expand = function(args)
        lua_snip.lsp_expand(args.body)
    end,
}

local formatting = {
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format({
        mode = "symbol_text",
        symbol_map = {
            Copilot = "",
        },
        before = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    }),
}

local mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-s>"] = cmp.mapping.complete({
        config = {
            sources = {
                { name = "copilot" },
            },
        },
    }),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif lua_snip.expandable() then
            lua_snip.expand()
        elseif lua_snip.expand_or_jumpable() then
            lua_snip.expand_or_jump()
        elseif check_backspace() then
            fallback()
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif lua_snip.jumpable(-1) then
            lua_snip.jump(-1)
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
}

local sources = {
    { name = "nvim_lsp" },
    { name = "copilot" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
    { name = "treesitter" },
    { name = "npm" },
    { name = "buffer" },
    { name = "path" },
}

local sorting = {
    --keep priority weight at 2 for much closer matches to appear above copilot
    --set to 1 to make copilot always appear on top
    priority_weight = 2,
    comparators = {
        -- order matters here
        cmp.config.compare.exact,
        has_copilot and copilot_cmp.prioritize or nil,
        has_copilot and copilot_cmp.score or nil,
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
}

local confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
}

local experimental = {
    native_menu = false,
    ghost_text = false,
}

local performance = {
    debounce = 150,
}

local options = {
    window = window,
    snippet = snippet,
    formatting = formatting,
    mapping = mapping,
    sources = sources,
    sorting = sorting,
    confirm_opts = confirm_opts,
    experimental = experimental,
    performance = performance,
    preselect = cmp.PreselectMode.Item,
}

-- '/'
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
-- `:`
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

cmp.setup(options)
