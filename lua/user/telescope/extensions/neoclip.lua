local status_ok, neoclip = pcall(require, "neoclip")

if not status_ok then
  return
end

neoclip.setup {
  enable_persistent_history = true,
  length_limit = 1048576,
  continuous_sync = false,
  default_register = "*",
  -- db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  keys = {
    telescope = {
      i = {
        select = "<cr>",
        paste = "<cr>",
        paste_behind = "<a-p>",
        replay = "<c-q>", -- replay a macro
        delete = "<c-d>", -- delete an entry
        custom = {},
      },
    },
  },
}

local wk_ok, which_key = pcall(require, "which-key")
if not wk_ok then
  return
end

local opts = require("user.whichkey.settings").opts

local mappings = {
  p = { "<cmd>Telescope neoclip<cr>", "Yank history" },
}

which_key.register(mappings, opts)
