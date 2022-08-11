local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"
local mappings = {
  g = {
    name = "Git",
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = {
      "<cmd>Gitsigns undo_stage_hunk<cr>",
      "Undo Stage Hunk",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
}

which_key.register(mappings, wk_settings.opts)
