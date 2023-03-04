import({ "copilot", "copilot_cmp" }, function(modules)
    local copilot_cmp = modules["copilot_cmp"]

    modules.copilot.setup({
        suggestion = { enabled = false },
        panel = {
            auto_refresh = true,
        },
    })
    copilot_cmp.setup()
end)
