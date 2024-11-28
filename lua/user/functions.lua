local M = {}

function M.save_and_exit()
  -- write all buffers first
  vim.api.nvim_command ":wa"
  -- quit all buffers
  vim.api.nvim_command ":qa"
end

function M.qf_toggle()
  vim.api.nvim_command [[
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
]]
end

return M
