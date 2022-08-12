local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_setting = require "user.whichkey.settings"

local mappings = {
  m = { "<cmd>TZMinimalist<CR>", "Minimalist mode" },
  z = {
    name = "Zen mode",
    f = { "<cmd>TZFocus<CR>", "Focus current file" },
    m = { "<cmd>TZMinimalist<CR>", "Minimalist mode" },
    a = { "<cmd>TZAtaraxis<CR>", "Narrow mode current file" },
  },
}
local vmappings = {
  z = {
    name = "Zen mode",
    n = { ":'<,'>TZNarrow<CR>", "Narrow mode selection" },
  },
}

which_key.register(mappings, wk_setting.opts)
which_key.register(vmappings, wk_setting.vopts)
