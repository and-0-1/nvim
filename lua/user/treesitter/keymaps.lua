local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local mappings = {
  T = {
    name = "Treesitter",
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  },
}

which_key.register(mappings, wk_settings.opts)
