local status_ok, mellow = pcall(require, "mellow")
if not status_ok then
  return
end

local colors = require("mellow.colors").dark

local colorscheme = "mellow"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
