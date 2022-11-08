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

-- NOTE: color highlight overrides
vim.api.nvim_set_hl(0, "Function", { fg = colors.bright_blue, italic = true })
vim.api.nvim_set_hl(0, "Keyword", {
  fg = colors.blue,
  bold = true,
})
vim.api.nvim_set_hl(0, "Winbar", { fg = colors.white, bg = nil })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue })
