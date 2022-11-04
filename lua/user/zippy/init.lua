-- Setup nvim-cmp.
local status_ok, zippy = pcall(require, "zippy")
if not status_ok then
  return
end

zippy.setup {}

require "user.zippy.keymaps"
