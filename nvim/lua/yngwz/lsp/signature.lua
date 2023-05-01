local signature = require("lsp_signature")

    signature.setup({
        bind = true,
        handler_opts = {
            border = "rounded",
        },
        toggle_key = "<M-x>",
        floating_window = false,
    })
