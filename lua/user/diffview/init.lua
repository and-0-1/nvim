local ok = pcall(require, "diffview.actions")

if not ok then
  vim.notify "Diffview issues"
  return
end

require("diffview").setup()

require "user.diffview.keymaps"
