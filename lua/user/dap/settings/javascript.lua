local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.node2 = {
    type = "executable",
    command = "node-debug2-adapter",
  }

  dap.adapters.chrome = {
    type = "executable",
    command = "chrome-debug-adapter",
  }

  dap.configurations.javascript = {
    -- CHROME - frontend
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
    -- NODE - backend
    {
      name = "Run script",
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = "Attach to process",
      type = "node2",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
  }

  dap.configurations.javascriptreact = {
    -- CHROME - frontend
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
end

return M
