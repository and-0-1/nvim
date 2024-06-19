local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    -- add = { text = "▎" },
    -- change = { text = "▎" },
    -- delete = { text = "󰐊" },
    -- topdelete = { text = "󰐊" },
    -- changedelete = { text = "▎" },
  },
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("<leader>gj", "<cmd>Gitsigns next_hunk<cr>")
nnoremap("<leader>gk", "<cmd>Gitsigns prev_hunk<cr>")
nnoremap("<leader>gl", "<cmd>Gitsigns blame_line<cr>")
nnoremap("<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")
nnoremap("<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")
nnoremap("<leader>gR", "<cmd>Gitsigns reset_buffer<cr>")
