local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node-debug2-adapter",
}

dap.adapters.chrome = {
  type = "executable",
  command = "chrome-debug-adapter",
}

dap.adapters.nlua = function(callback, config)
  callback { type = "server", host = config.host, port = config.port }
end

dap.adapters.php = {
  type = "executable",
  command = "php-debug-adapter",
  -- args = {"/opt/vscode-php-debug/out/phpDebug.js"},
}
