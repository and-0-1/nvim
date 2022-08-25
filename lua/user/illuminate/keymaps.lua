local opts = { noremap = true, silent = true, nowait = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-n>", ":lua require('illuminate').goto_next_reference()<CR>", opts)
keymap("n", "<C-p>", ":lua require('illuminate').goto_prev_reference()<CR>", opts)
