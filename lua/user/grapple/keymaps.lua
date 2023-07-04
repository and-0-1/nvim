local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local opts = wk_settings._opts
local m_opts = wk_settings.m_opts

local mmappings = {
  name = "Grapple",
  f = { '<cmd>lua require("user.grapple.picker")()<cr>', "Find" },
  a = { '<cmd>lua require("grapple").toggle()<cr>', "Add" },
  u = { '<cmd>lua require("grapple").popup_tags()<cr>', "Quick menu" },
  h = { '<cmd>lua require("grapple").cycle_backward()<cr>', "Next mark" },
  l = { '<cmd>lua require("grapple").cycle_forward()<cr>', "Previous mark" },
}

which_key.register(mappings, opts)
which_key.register(mmappings, m_opts)
