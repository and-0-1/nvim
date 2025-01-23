local Job = require "plenary.job"

local M = {}

M.get_git_branch = function(file_path)
  local j = Job:new {
    command = "git",
    args = { "branch", "--show-current" },
    cwd = vim.fn.fnamemodify(file_path, ":h"),
  }

  local ok, result = pcall(function()
    return vim.trim(j:sync()[1])
  end)

  if ok then
    return result
  end
end

return M
