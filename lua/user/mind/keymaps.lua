local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local mappings = {
  n = {
    name = "Notes",
    g = { "<cmd>MindOpenMain<cr>", "Global notes" },
    p = { "<cmd>MindOpenProject<cr>", "Project notes" },
  },
}

which_key.register(mappings, wk_settings.opts)
