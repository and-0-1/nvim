local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = require("user.whichkey.settings").opts

local mappings = {
  l = {
    g = { "<cmd>lua require('zippy').insert_print()<CR>", "Print value" },
  },
}

which_key.register(mappings, opts)
