local ls = require("luasnip")
local s = ls.s

-- This is a format node
-- It takes a format string and a list of nodes
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position and optionally some default text
local i = ls.insert_node

--repeats a node
local rep = require("luasnip.extras").rep

ls.snippets = {
    lua = {
        s("r", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
    },
}
