local api = vim.api

local opts = { noremap = true, silent = true, nowait = true }

-- TODO: fix issues when applying modes on top of each other (e.g. ataraxis when in minimalist)
-- api.nvim_set_keymap("n", "<leader>n", ":TZNarrow<CR>", opts)
api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", opts)
api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", opts)
api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", opts)
api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts)
