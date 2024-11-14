local ok, grapple = pcall(require, "grapple")
if not ok then
  vim.notify "grapple load issue"
  return
end

grapple.setup {
  icons = false,
}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("ma", require("grapple").toggle)
nnoremap("mu", require("grapple").toggle_tags)
nnoremap("mh", '<cmd>lua require("grapple").cycle("backward", { scope = "cwd" })<cr>')
nnoremap("ml", '<cmd>lua require("grapple").cycle("forward", { scope = "cwd" })<cr>')
nnoremap("mf", "<cmd>Telescope grapple tags<cr>")
