local mason_status_ok, mason = pcall(require, "mason")
local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("lspconfig missing", vim.log.levels.ERROR)
  return
end
if not (mason_status_ok or mason_lsp_status_ok) then
  vim.notify("mason or mason_lsp missing", vim.log.levels.ERROR)
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  "jsonls",
  "lua_ls",
  "tflint",
  -- "ts_ls",
  "tsgo",
  "yamlls",
  "bashls",
  "prosemd_lsp",
  -- "rust_analyzer",
  -- "vimls",
  "tailwindcss",
  -- "graphql",
  -- "csharp_ls",
  "eslint",
  "typos_lsp",
  -- "angularls",
  -- "gopls",
  -- "vuels",
  "clangd",
  -- "denols",
  -- "pylsp",
  -- "pyright",
  -- "ruff",
  -- "omnisharp",
}

local shared_capabilities = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

-- TODO(ando): move these into ftplugin
for index, server_name in pairs(servers) do
  local server_opts
  if server_name == "jsonls" then
    server_opts = vim.tbl_deep_extend("force", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }, shared_capabilities)
  elseif server_name == "eslint" then
    server_opts = vim.tbl_deep_extend("force", {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "graphql",
      },
    }, shared_capabilities)
  elseif server_name == "clangd" then
    server_opts = vim.tbl_deep_extend("force", {
      filetypes = { "objc", "objcpp", "cpp", "c" },
      capabilities = {
        offsetEncoding = { "utf-8" },
      },
    }, shared_capabilities)
  else
    server_opts = shared_capabilities
  end

  vim.lsp.config[server_name] = server_opts
  vim.lsp.enable(server_name)
end

local settings = {
  ui = {
    border = "rounded",
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 10,
}

mason.setup(settings)
mason_lsp.setup {
  ensure_installed = servers,
  automatic_installation = true,
}
