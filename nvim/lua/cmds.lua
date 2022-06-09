local async = require("plenary.async")
local notify = require("notify")

-- TODO set notify as the default notifucation option

local packer_sync = function()
    async.run(function()
        notify.async("Syncing packer.", "info", {
            title = "Packer",
        })
    end)

    local snap_shot_time = os.date("!%Y-%m-%dT%TZ")
    vim.cmd("PackerSnapshot " .. snap_shot_time)
    vim.cmd("PackerSync")
end

local M = {}

vim.api.nvim_create_user_command("PackerSnapSync", packer_sync, {
    desc = "Creates a packer snapshot and then runs PackerSync",
})

M.packer_sync = packer_sync

return M
