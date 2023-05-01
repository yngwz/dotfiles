local present, catppuccin = pcall(require, "catppuccin")

if not present then
    return
end

vim.g.catppuccin_flavour = "frappe"

local integrations = {
    aerial = false,
    barbar = false,
    beacon = false,
    cmp = true,
    coc_nvim = false,
    dashboard = false,
    fern = false,
    fidget = false,
    gitgutter = false,
    gitsigns = true,
    harpoon = true,
    hop = false,
    illuminate = true,
    leap = false,
    lightspeed = false,
    lsp_saga = true,
    lsp_trouble = false,
    markdown = true,
    mini = false,
    neogit = false,
    neotest = false,
    neotree = false,
    notify = true,
    nvimtree = true,
    overseer = false,
    pounce = false,
    symbols_outline = false,
    telekasten = false,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    vim_sneak = false,
    vimwiki = false,
    which_key = true,

    -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    dap = {
        enabled = false,
        enable_ui = false,
    },
    indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
    },
    native_lsp = {
        enabled = true,
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
        },
    },
    navic = {
        enabled = false,
        custom_bg = "NONE",
    },
}

local settings = {
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    color_overrides = {},
    custom_highlights = {},
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = integrations,
}

catppuccin.setup(settings)
