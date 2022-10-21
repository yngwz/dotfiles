local dap = require("dap")
if not dap then
    return
end

local mason_dap = require("mason-nvim-dap")
if not mason_dap then
    return
end

mason_dap.setup({
    ensure_installed = {
        "chrome",
        "node2",
        "firefox",
    },
    automatic_installation = true,
})

-- Adapters: Node and TypeScript
dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = {
        os.getenv("HOME")
            .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
    },
}

-- Adapters: Chrome
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {
        os.getenv("HOME")
            .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
    },
}

dap.configurations.javascript = {
    {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    },
}

dap.configurations.javascript = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.javascriptreact = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.typescriptreact = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.set_log_level("TRACE")

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
