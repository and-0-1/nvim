-- colorscheme settings
require "user.colorscheme.rose-pine"
require "user.colorscheme.mellow"

local colorscheme = "mellow"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
