local dap = require "dap"

-- NOTE: not working correctly
local chrome_settings = {
  type = "chrome",
  request = "attach",
  program = "${file}",
  cwd = vim.fn.getcwd(),
  sourceMaps = true,
  -- url = function()
  --   local val = vim.fn.input("URL: ", "http://localhost:8080")
  --   assert(val, "Please provide a url")
  --   return val
  -- end,
  breakOnLoad = true,
  protocol = "inspector",
  port = 9222,
  webRoot = "${workspaceFolder}/src",
}

dap.configurations.javascript = {
  -- CHROME - frontend
  chrome_settings,
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
  chrome_settings,
}
