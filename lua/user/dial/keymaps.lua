local map = require "dial.map"

-- TODO: move these to own file
-- change augends in VISUAL mode
local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("<C-a>", map.inc_normal "mygroup")
nnoremap("<C-x>", map.dec_normal "mygroup")
nnoremap("<C-a>", map.inc_normal "visual")
nnoremap("<C-x>", map.dec_normal "visual")
