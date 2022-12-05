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
-- highlight
vim.api.nvim_set_hl(0, "Winbar", { fg = colors.white, bg = nil })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue })
vim.api.nvim_set_hl(0, "Visual", { bg = colors.gray04 })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.gray04 })
vim.api.nvim_set_hl(0, "Search", { fg = colors.bright_yellow, bg = colors.bright_black })
-- cmp
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchDefault", { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzyDefault", { fg = colors.bright_blue })
-- notify
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.cyan })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.green })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.gray05 })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors.bright_red })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors.bright_green })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors.gray03 })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = colors.bright_red })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors.bright_green })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors.gray03 })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = colors.bright_blue })

-- vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = colors.bg })
