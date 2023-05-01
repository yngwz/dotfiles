local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
    return
end

-- local catppuccin_present, catppuccin_colors = pcall(
--     require,
--     "catppuccin.palettes"
-- )
-- if not catppuccin_present then
--     print("no catppuccin colors available")
-- end

-- local colors = catppuccin_colors.get_palette()

treesitter.setup({
	ensure_installed = {
			"lua",
			"markdown",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"prisma",
			"json",
			"svelte",
			"scss",
			"c",
			"python",
			"pug",
			"php",
			"java",
			"astro",
			"vue",
			"dockerfile",
			"graphql",
			"yaml",
			"toml",
		},
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "haskell" }, -- list of parsers to ignore installing
    matchup = {
        enable = true,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<leader>gnn",
            node_incremental = "<leader>gnr",
            scope_incremental = "<leader>gne",
            node_decremental = "<leader>gnt",
        },
    },

    indent = {
        enable = false,
        disable = {},
    },
    autotag = {
        enable = true,
    },

    rainbow = {
        enable = true,
        extended_mode = true,
        -- colors = {
        --     colors.overlay2,
        --     colors.peach,
        --     colors.sky,
        --     colors.pink,
        --     colors.teal,
        --     colors.lavendar,
        --     colors.red,
        --     colors.mauve,
        --     colors.yellow,
        --     colors.flamingo,
        --     colors.sky,
        -- },
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },

    playground = {
        enable = false,
        disable = {},
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
})

local context_present, context = pcall(require, "treesitter-context")

if not context_present then
    print("context not present")
    return
end

context.setup({
    enable = true,
    max_lines = -1, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
