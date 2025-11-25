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
  -- NOTE: we first do "mark '" to add current position to jumplist, that way if definition/reference/etc.. is in the same file
  -- we can do ctrl+o to go back to where we were
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>mark ' | lua vim.lsp.buf.definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>mark ' | lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>mark ' | Telescope lsp_implementations<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>mark ' | Telescope lsp_references<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help({border = 'rounded'})<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(
  --   bufnr,
  --   "n",
  --   "<leader>lf",
  --   "<cmd>lua require('user.lsp.handlers').null_ls_format()<cr>",
  --   opts
  -- )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set("n", "<leader>lv", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config { virtual_lines = new_config }
  end, { desc = "Toggle diagnostic virtual_lines", buffer = true })

  -- vim.api.nvim_buf_set_keymap(
  --   bufnr,
  --   "n",
  --   "<leader>lt",
  --   '<cmd>lua require("user.lsp.handlers").toggle_diagnostics()<cr>',
  --   opts
  -- )
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

function M.enable_format_on_save()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
    pattern = { "*" },
    callback = function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name ~= "ts_ls"
        end,
      }
    end,
  })
  vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  vim.api.nvim_del_augroup_by_name "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.null_ls_format()
  vim.lsp.buf.format {
    -- async = true,
    filter = function(client)
      return client.name == "null-ls"
    end,
  }
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

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]
vim.cmd [[ command! NullLsFormat execute 'lua require("user.lsp.handlers").null_ls_format()' ]]
vim.cmd [[ command! Ft execute 'lua vim.lsp.buf.format()' ]]
vim.cmd [[ command! Diag execute 'lua vim.diagnostic.setqflist()' ]]

M.enable_format_on_save()

return M
