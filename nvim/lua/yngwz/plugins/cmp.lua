local cmp_present, cmp = pcall(require, "cmp")
if not cmp_present then
    return
end

local cmp_window = require("cmp.utils.window")

local snip_present, lua_snip = pcall(require, "luasnip")
if not snip_present then
    return
end

local kind_icons = require("yngwz.plugins.lspkind_icons")

require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menuone,noselect"

-- Utils
local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local buffer_option = {
    -- Complete from all visible buffers (splits)
    get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
    end,
}

-- Setup
function cmp_window:has_scrollbar()
    return true
end

local window = {
    completion = {
        border = border("CmpBorder"),
    },
    documentation = {
        border = border("CmpDocBorder"),
    },
}

local snippet = {
    expand = function(args)
        lua_snip.lsp_expand(args.body)
    end,
}

local formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
        vim_item.menu = vim_item.kind
        vim_item.kind = kind_icons[vim_item.kind]
        return vim_item
    end,
    expand = function(args)
        require("luasnip").lsp_expand(args.body)
    end,
}

local mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
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
    { name = "nvim_lsp", priority = 9 },
    { name = "luasnip", priority = 9 },
    { name = "treesitter", priority = 9 },
    { name = "npm", priority = 9 },
    {
        name = "buffer",
        priority = 7,
        keyword_length = 5,
        option = buffer_option,
    },
    { name = "nvim_lua", priority = 5 },
    { name = "path", priority = 4 },
    { name = "calc", priority = 3 },
}

local sorting = {
    comparators = {
        cmp.config.compare.exact,
        cmp.config.compare.locality,
        cmp.config.compare.recently_used,
        cmp.config.compare.score,
        cmp.config.compare.offset,
        cmp.config.compare.sort_text,
        cmp.config.compare.order,
    },
}

local confirmation = {
    get_commit_characters = function()
        return {}
    end,
}

local experimental = {
    native_menu = false,
    ghost_text = false,
}

local options = {
    window = window,
    snippet = snippet,
    formatting = formatting,
    mapping = mapping,
    sources = sources,
    sorting = sorting,
    confirmation = confirmation,
    experimental = experimental,
}

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

cmp.setup(options)
