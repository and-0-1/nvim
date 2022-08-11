local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local mappings = {
  e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  E = { "<cmd>NvimTreeFindFile<cr>", "Find file in explorer" },
}

which_key.register(mappings, wk_settings.opts)
