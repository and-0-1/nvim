local status_ok, rp = pcall(require, "rose-pine")
if not status_ok then
  return
end

rp.setup()

local colorscheme = "rose-pine"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
