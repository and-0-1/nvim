local statusline = require "user.statusline"

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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("AndoGitBranch", { clear = true }),
  callback = function()
    if vim.bo.filetype == nil or vim.bo.filetype == "" then
      return
    end

    local current_file = vim.fn.expand "%:p"
    local branch = require("user.git_utils").get_git_branch(current_file)

    if branch then
      vim.wo.statusline = statusline.left .. " %#WarningMsg#[" .. branch .. "]%#StatusLine# " .. statusline.right
    else
      vim.wo.statusline = statusline.full
    end
  end,
})
