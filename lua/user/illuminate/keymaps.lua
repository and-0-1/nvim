local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

-- Shorten function name

nnoremap("<C-n>", ":lua require('illuminate').goto_next_reference()<CR>", { nowait = true })
nnoremap("<C-p>", ":lua require('illuminate').goto_prev_reference()<CR>", { nowait = true })
