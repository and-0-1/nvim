local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  vim.notify("cmp_nvim_lsp not found", vim.log.levels.ERROR)
  return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

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

-- TODO(ando): refactor this to be simpler, new nvim lsp api supports a lot of the capabilities we need
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)
  vim.keymap.set("n", "<leader>lv", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config { virtual_lines = new_config }
  end, { desc = "Toggle diagnostic virtual_lines", buffer = true })
end

M.on_attach = function(client, bufnr)
  -- vim.lsp.completion.enable(true, client.id, bufnr, {
  --   -- autotrigger = true,
  --   -- convert = function(item)
  --   --   return { abbr = item.label:gsub("%b()", "") }
  --   -- end,
  -- })
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
