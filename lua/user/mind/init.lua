local status_ok, mind = pcall(require, "mind")
if not status_ok then
  return
end

mind.setup {
  ui = {
    width = 50,
  },
}

require "user.mind.keymaps"
