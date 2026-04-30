local M = {}

M.capabilities = require("blink.cmp").get_lsp_capabilities()

M.setup = function()
  local config = {
    -- disable virtual text
    virtual_text = false,
    virtual_lines = false,
    -- show signs
    signs = {},
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
      -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    },
  }

  vim.diagnostic.config(config)
end

local function lsp_keymaps(bufnr)
  vim.keymap.set("n", "<leader>lv", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config { virtual_lines = new_config }
  end, { desc = "Toggle diagnostic virtual_lines", buffer = bufnr })
end

M.on_attach = function(client, bufnr)
  if vim.b[bufnr].large_buf then
    vim.diagnostic.enable(false, { bufnr = bufnr })
    vim.schedule(function()
      pcall(vim.lsp.buf_detach_client, bufnr, client.id)
      vim.diagnostic.reset(nil, bufnr)
    end)
    return
  end
  lsp_keymaps(bufnr)
end

local diagnostics_active = true
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

vim.cmd [[ command! Ft execute 'lua vim.lsp.buf.format()' ]]
vim.cmd [[ command! Diag execute 'lua vim.diagnostic.setloclist()' ]]
vim.cmd [[ command! GDiag execute 'lua vim.diagnostic.setqflist()' ]]

return M
