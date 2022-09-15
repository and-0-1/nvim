local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = require("user.whichkey.settings").opts

local mappings = {
  b = { "<cmd>Telescope buffers<CR>", "Buffers" },
  f = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = {
      "<cmd>lua require('user.telescope.finders').project_files()<cr>",
      "Find files",
    },
    t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    w = { "<cmd>Telescope grep_string<cr>", "Find Word on Cursor" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  g = {
    name = "Git",
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  },
  l = {
    d = {
      "<cmd>Telescope diagnostics<cr>",
      "Diagnostics",
    },
  },
}

which_key.register(mappings, opts)
