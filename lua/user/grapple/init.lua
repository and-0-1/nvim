local ok, grapple = pcall(require, "grapple")
if not ok then
  vim.notify "grapple load issue"
  return
end

grapple.setup {}

-- Create a fallback scope resolver that first tries to use the LSP for a scope
-- path, then looks for a ".git" repository, and finally falls back on using
-- the initial working directory that neovim was started in
require("grapple.scope").fallback {
  require("grapple").resolvers.lsp_fallback,
  require("grapple").resolvers.static,
}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("mf", '<cmd>lua require("user.grapple.picker")()<cr>')
nnoremap("ma", '<cmd>lua require("grapple").toggle()<cr>')
nnoremap("mu", '<cmd>lua require("grapple").popup_tags()<cr>')
nnoremap("mh", '<cmd>lua require("grapple").cycle_backward()<cr>')
nnoremap("ml", '<cmd>lua require("grapple").cycle_forward()<cr>')
