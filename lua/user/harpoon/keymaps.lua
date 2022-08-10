local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local m_opts = require("user.whichkey.settings").m_opts

local m_mappings = {
  name = "Harpoon",
  a = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Add" },
  h = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Next mark" },
  l = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Previous mark" },
  u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Quick menu" },
  f = { "<cmd>Telescope harpoon marks<cr>", "Search" },
}

which_key.register(m_mappings, m_opts)
