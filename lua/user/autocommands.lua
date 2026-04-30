local statusline = require "user.statusline"

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("AndoQForExit", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo" },
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

local branch_group = vim.api.nvim_create_augroup("AndoGitBranch", { clear = true })

local function update_branch_statusline()
  if vim.bo.filetype == "" then
    return
  end
  local branch = vim.b.gitsigns_head
  if branch and branch ~= "" then
    vim.wo.statusline = statusline.left .. " %#WarningMsg#[" .. branch .. "]%#StatusLine# " .. statusline.right
  else
    vim.wo.statusline = statusline.full
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = branch_group,
  callback = update_branch_statusline,
})

vim.api.nvim_create_autocmd("User", {
  group = branch_group,
  pattern = "GitSignsUpdate",
  callback = update_branch_statusline,
})
