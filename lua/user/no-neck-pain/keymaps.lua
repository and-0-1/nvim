local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local keymap = {
  ["N"] = {
    "<cmd>NoNeckPain<cr>",
    "Toggle NoNeckPain",
  },
}

which_key.register(keymap, wk_settings.opts)
