local M = {}

function M.setup()
  -- https://github.com/xdebug/vscode-php-debug/releases
  -- Extract the vsix content
  local dap = require "dap"
  dap.adapters.php = {
    type = "executable",
    command = "php-debug-adapter",
    -- args = {"/opt/vscode-php-debug/out/phpDebug.js"},
  }

  dap.configurations.php = {
    {
      type = "php",
      request = "launch",
      name = "Listen for xdebug",
      port = "9000",
      -- log = true,
      pathMappings = {
        -- ["/sailthru/api-php"] = "${workspaceFolder}",
        ["/sailthru/commons"] = "${workspaceFolder}/commons",
        ["/sailthru/api-php"] = "${workspaceFolder}/api",
      },
    },
  }
end

return M
