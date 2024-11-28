local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
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
    },
  }

  vim.diagnostic.config(config)

  local doc_window_settings = {
    border = "rounded",
    -- width = 80,
  }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, doc_window_settings)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, doc_window_settings)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>lf",
    "<cmd>lua require('user.lsp.handlers').null_ls_format()<cr>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lv", '<cmd>lua require("lsp_lines").toggle()<cr>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>lt",
    '<cmd>lua require("user.lsp.handlers").toggle_diagnostics()<cr>',
    opts
  )
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

function M.enable_format_on_save()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
    pattern = { "*" },
    callback = function()
      M.null_ls_format()
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
    async = true,
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
vim.cmd [[ command! LspFormat execute 'lua require("user.lsp.handlers").null_ls_format()' ]]

M.enable_format_on_save()

return M
