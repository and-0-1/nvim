local status_ok = pcall(require, "mellow")
if not status_ok then
  return
end

local colorscheme = "mellow"

local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
