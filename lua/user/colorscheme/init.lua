-- colorscheme settings
require "user.colorscheme.rose-pine"
-- require "user.colorscheme.tokyonight"

local blueHighlight = {
  bg = "#0000af", --[[ fg = "#ffffff" ]]
}
-- NOTE(ando): cursor color is controlled by kitty conf. But we put it here
-- just for completeness
local cursor_colors = {
  bg = "#40FF40",
  fg = "#000000",
}
vim.api.nvim_set_hl(0, "Visual", blueHighlight)
vim.api.nvim_set_hl(0, "CursorLine", blueHighlight)
vim.api.nvim_set_hl(0, "Cursor", cursor_colors)
