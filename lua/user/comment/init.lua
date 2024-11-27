local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = { line = "gcc", block = "gbc" },
  opleader = { line = "gc", block = "gb" },
  extra = { above = "gcO", below = "gco", eol = "gcA" },
  mappings = { basic = true, extra = true },
  post_hook = nil,
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}

local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>')
vnoremap("<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
