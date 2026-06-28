local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.setup = function()
  local config = {
    -- disable virtual text
    virtual_text = false,
    virtual_lines = false,
    -- show signs
    signs = false,
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
  if client.name == "tsgo" or client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
  client.server_capabilities.semanticTokensProvider = nil
  lsp_keymaps(bufnr)

  if client:supports_method "textDocument/completion" then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end

  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if vim.snippet.active { direction = 1 } then
      vim.snippet.jump(1)
    end
  end, { buffer = bufnr })
  vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if vim.snippet.active { direction = -1 } then
      vim.snippet.jump(-1)
    end
  end, { buffer = bufnr })
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
