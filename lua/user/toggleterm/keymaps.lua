local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap
local wk_settings = require "user.whichkey.settings"

nnoremap("<C-t>", "<cmd>ToggleTerm<cr>", { silent = true })

local mappings = {
  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    t = { "<cmd>ToggleTerm<cr>", "Terminal" },
    p = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },
  },
}

which_key.register(mappings, wk_settings.opts)
