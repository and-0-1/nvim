local ok, cybu = pcall(require, "cybu")
if not ok then
  return
end

local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true, nowait = true }

keymap("n", "H", "<Plug>(CybuPrev)", keymap_opts)
keymap("n", "L", "<Plug>(CybuNext)", keymap_opts)

cybu.setup {
  position = {
    relative_to = "win", -- win, editor, cursor
    anchor = "topright", -- topleft, topcenter, topright,
    -- centerleft, center, centerright,
    -- bottomleft, bottomcenter, bottomright
    -- vertical_offset = 10, -- vertical offset from anchor in lines
    -- horizontal_offset = 0, -- vertical offset from anchor in columns
    -- max_win_height = 5, -- height of cybu window in lines
    max_win_width = 0.33, -- integer for absolute in columns
    -- float for relative to win/editor width
  },
  display_time = 1750, -- time the cybu window is displayed
  style = {
    path = "relative", -- absolute, relative, tail (filename only)
    border = "rounded", -- single, double, rounded, none
    separator = " ", -- string used as separator
    prefix = "…", -- string used as prefix for truncated paths
    padding = 1, -- left & right padding in number of spaces
    hide_buffer_id = true,
    devicons = {
      enabled = true, -- enable or disable web dev icons
      colored = true, -- enable color for web dev icons
    },
  },
}
