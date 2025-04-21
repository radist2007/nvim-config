-- plugins/dap.lua
local dap = require("dap")
local dapui = require("dapui")

-- UI
require("dapui").setup()

-- PHP (Xdebug)
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv("HOME") .. '/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      ["/var/www/html"] = vim.fn.getcwd(),
    },
  },
}

-- JavaScript (Node.js)
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv("HOME") .. '/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = "Launch Node.js",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

