local status_ok, mellow = pcall(require, "mellow")
if not status_ok then
  return
end

local colors = require "mellow.colors"

-- vim.g.mellow_italic_functions = true
-- vim.g.mellow_bold_functions = true
-- vim.g.mellow_bold_variables = true
-- vim.g.mellow_bold_keywords = true

local colorscheme = "mellow"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.api.nvim_set_hl(0, "Function", { fg = colors.dark.bright_blue, italic = true })
vim.api.nvim_set_hl(0, "Keyword", {
  fg = colors.dark.blue,
  bold = true,
  -- standout = true,
})
