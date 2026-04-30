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

local shared = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local function server_opts(name)
  local module = "user.lsp.servers." .. name
  if package.searchpath(module, package.path) then
    return vim.tbl_deep_extend("force", require(module), shared)
  end
  return shared
end

for _, name in ipairs(servers) do
  vim.lsp.config[name] = server_opts(name)
  vim.lsp.enable(name)
end

mason.setup {
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

mason_lsp.setup {
  ensure_installed = servers,
  automatic_installation = true,
}
