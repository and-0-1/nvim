vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("AndoQForExit", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "DressingSelect" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = vim.api.nvim_create_augroup("AndoYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
