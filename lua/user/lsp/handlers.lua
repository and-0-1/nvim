local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  local icons = require "user.icons"
  local signs = {

    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    -- virtual_text = {
    --   -- spacing = 7,
    --   -- update_in_insert = false,
    --   -- severity_sort = true,
    --   -- prefix = "<-",
    --   prefix = "●",
    --   source = "if_many", -- Or "always"
    --   -- format = function(diag)
    --   --   return diag.message .. "blah"
    --   -- end,
    -- },
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = false,
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
    width = 60,
  }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, doc_window_settings)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, doc_window_settings)
end

local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua require("user.lsp.handlers").null_ls_format()' ]]
end

-- local notify_status_ok, notify = pcall(require, "notify")
-- if not notify_status_ok then
--   return
-- end

-- local ih_ok, ih = pcall(require, "inlay-hints")

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
  -- attach_navic(client, bufnr)

  -- if ih_ok then
  --   -- ih.on_attach(client, bufnr)
  -- end
  -- if client.name == "tsserver" or client.name == "sumneko_lua" then
  --   ih.on_attach(client, bufnr)
  -- end

  if client.name == "jdt.ls" then
    M.capabilities.textDocument.completion.completionItem.snippetSupport = false
    vim.lsp.codelens.refresh()
  end
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

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]

M.enable_format_on_save()

return M
