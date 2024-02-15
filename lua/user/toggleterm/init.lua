local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 16
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.50
    end
  end,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "FloatBorder",
      background = "Normal",
    },
    -- height = 30,
    width = 150,
  },
}

local function set_terminal_keymaps()
  local opts = { noremap = true, nowait = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc><esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-t>", "<cmd>ToggleTerm<cr>", opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    set_terminal_keymaps()
  end,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", direction = "float", hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>")
nnoremap("<leader>th", "<cmd>ToggleTerm size=20 direction=horizontal<cr>")
nnoremap("<leader>tf", "<cmd>ToggleTerm direction=float<cr>")
nnoremap("<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>")
