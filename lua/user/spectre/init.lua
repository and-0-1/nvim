local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
  return
end

spectre.setup {}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("<leader>rr", "<cmd>lua require('spectre').open()<cr>")
nnoremap("<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>")
nnoremap("<leader>rf", "<cmd>lua require('spectre').open_file_search()<cr>")
