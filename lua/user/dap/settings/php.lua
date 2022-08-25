-- https://github.com/xdebug/vscode-php-debug/releases
-- Extract the vsix content
local dap = require "dap"

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for xdebug",
    port = function()
      local val = tonumber(vim.fn.input("Port: ", "9000"))
      assert(val, "Please provide a port number")
      return val
    end,
    -- log = true,
    pathMappings = {
      ["/sailthru/commons"] = "${workspaceFolder}/commons",
      ["/sailthru/api-php"] = "${workspaceFolder}/api",
      ["/sailthru/ui"] = "${workspaceFolder}/ui",
    },
  },
}
