vim.cmd.colorscheme "ansi"

-- Re-apply colorscheme when &background flips (e.g. async OSC 11 response
-- from the terminal lands after startup, or :set background=... at runtime).
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd.colorscheme "ansi"
  end,
})

-- local blueHighlight = {
--   bg = "#0000af", --[[ fg = "#ffffff" ]]
-- }
-- NOTE(ando): cursor color is controlled by kitty conf. But we put it here
-- just for completeness
-- local cursor_colors = {
--   bg = "#40FF40",
--   fg = "#000000",
-- }
-- vim.api.nvim_set_hl(0, "Visual", blueHighlight)
-- vim.api.nvim_set_hl(0, "CursorLine", blueHighlight)
-- vim.api.nvim_set_hl(0, "Cursor", cursor_colors)
--
-- require "user.colorscheme.simple"
