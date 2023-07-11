local copilot = require("copilot")
local copilot_cmp = require("copilot_cmp")

copilot.setup({
    suggestion = { enabled = false },
    panel = {
        auto_refresh = true,
    },
})

copilot_cmp.setup()
