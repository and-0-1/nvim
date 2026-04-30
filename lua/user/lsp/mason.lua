local mason = require "mason"
local mason_lsp = require "mason-lspconfig"

local servers = {
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "tsgo",
  "yamlls",
  "bashls",
  "tailwindcss",
  "eslint",
  "clangd",
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
        "typescript",
        "typescriptreact",
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
