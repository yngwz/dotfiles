local dap_p, dap = pcall(require, "dap")

if not dap_p then
    return
end

local mason_p, mason = pcall(require, "mason-nvim-dap")

if not mason_p then
    return
end

mason.setup({
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

local vscode_p, vscode = pcall(require, "dap-vscode-js")
if not vscode_p then
    return
end

vscode.setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug",  Path to vscode-js-debug installation.
    debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = {
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
    }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            },
        },
    }
end

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
