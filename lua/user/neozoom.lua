local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }

require("neo-zoom").setup { -- use the defaults or UNCOMMENT and change any one to overwrite
  left_ratio = 0,
  top_ratio = 0,
  width_ratio = 1,
  height_ratio = 1,
  border = "single",
}

vim.keymap.set("n", "<CR>", function()
  vim.cmd "NeoZoomToggle"
end, NOREF_NOERR_TRUNC)

local cur_buf
-- My setup (This requires NeoNoName.lua, and optionally NeoWell.lua)
vim.keymap.set("n", "<CR>", function()
  -- Pop-up Effect
  if vim.api.nvim_win_get_config(0).relative == "" then
    cur_buf = vim.fn.bufnr()
    vim.cmd "NeoZoomToggle"
    vim.api.nvim_set_current_buf(cur_buf)
    return
  end
  vim.cmd "NeoZoomToggle"
  vim.api.nvim_set_current_buf(cur_buf)
  cur_buf = nil
  -- vim.cmd('NeoWellJump') -- you can safely remove this line.
end, NOREF_NOERR_TRUNC)
