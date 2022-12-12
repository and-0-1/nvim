local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local m_opts = require("user.whichkey.settings").m_opts

local mappings = {
  name = "Grapple",
  a = { '<cmd>lua require("grapple").toggle()<cr>', "Add" },
  h = { '<cmd>lua require("grapple").cycle_backward()<cr>', "Next mark" },
  l = { '<cmd>lua require("grapple").cycle_forward()<cr>', "Previous mark" },
  u = { '<cmd>lua require("grapple").popup_tags()<cr>', "Quick menu" },
  -- f = { "<cmd>Telescope harpoon marks<cr>", "Search" },
}

which_key.register(mappings, m_opts)
