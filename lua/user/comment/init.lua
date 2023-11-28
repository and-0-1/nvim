local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>')
vnoremap("<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
