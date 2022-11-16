local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"
local mappings = {
  g = {
    name = "Git",
    h = { "<cmd>DiffviewFileHistory %<cr>", "History" },
    x = { "<cmd>DiffviewClose <cr>", "Close History" },
  },
}

which_key.register(mappings, wk_settings.opts)
