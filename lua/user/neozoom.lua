local keymap = vim.api.nvim_set_keymap
keymap("n", "<CR>", "<cmd>NeoZoomToggle<CR>", { noremap = true, silent = true, nowait = true })
