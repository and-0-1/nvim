-- colorscheme settings
require "user.colorscheme.rose-pine"

local colorscheme = "rose-pine"
-- vim.g.tokyonight_style = "night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
