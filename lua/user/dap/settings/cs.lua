local dap = require "dap"

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      local path = vim.fn.getcwd()
      local sep = path:match "[/\\]" -- Get the path separator used (either / or \)
      local last_dir = path:match("([^" .. sep .. "]+" .. sep .. "?)$")
      local project_name = last_dir:sub(1, -1) -- Remove the trailing separator if it exists
      local version_directory = path .. "/bin/Debug"
      local latest_version = "net8.0"
      -- logger:info('Hieghest version: ' .. latest_version)
      local executable_path = version_directory .. "/" .. latest_version .. "/" .. project_name .. ".dll"
      -- local tokens = string.gmatch(path, "\\")
      -- local project_name = tokens[#(tokens) - 1] .. "\\"
      -- if Moaid_config.debug_dllPath ~= nill then
      --   executable_path = Moaid_config.debug_dllPath
      -- end

      local result = vim.fn.input("Path to dll: ", executable_path, "file")
      -- logger:info('Result: ' .. result)
      return result
    end,
    -- env = {
    --   ASPNETCORE_ENVIRONMENT = function()
    --     -- todo: request input from ui
    --     return "Development"
    --   end,
    --   ASPNETCORE_URLS = function()
    --     -- todo: request input from ui
    --     return "http://localhost:12345"
    --   end,
    --   EP_ENVIRONMENT_NAME = function()
    --     return "Test"
    --   end,
    --   AWS_PROFILE = function()
    --     return "dev"
    --   end,
    --   AWS_REGION = function()
    --     return "ap-southeast-2"
    --   end,
    --   IS_LOCAL = function()
    --     return true
    --   end,
    -- },
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}
