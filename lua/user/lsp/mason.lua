local mason_status_ok, mason = pcall(require, "mason")
local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not (mason_status_ok or mason_lsp_status_ok) then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  -- "jdtls",
  -- "clangd",
  "jsonls",
  "lua_ls",
  "tflint",
  "ts_ls",
  -- "pyright",
  "yamlls",
  "bashls",
  -- "intelephense",
  "prosemd_lsp",
  "rust_analyzer",
  "vimls",
  -- "arduino_language_server"
  "tailwindcss",
  "graphql",
  -- "denols",
  -- "omnisharp",
  "csharp_ls",
  "pylsp",
  "eslint",
  "typos_lsp",
}

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

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local server_opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}
mason_lsp.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup(server_opts)
  end,
  -- ["tsserver"] = function(server_name)
  --   local tsserver_opts = require "user.lsp.settings.tsserver"
  --   server_opts = vim.tbl_deep_extend("force", tsserver_opts, server_opts)
  --   lspconfig[server_name].setup(server_opts)
  -- end,
  ["jsonls"] = function(server_name)
    local jsonls_opts = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
    server_opts = vim.tbl_deep_extend("force", jsonls_opts, server_opts)
    lspconfig[server_name].setup(server_opts)
  end,
  ["clangd"] = function(server_name)
    server_opts = vim.tbl_deep_extend("force", {
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
    }, server_opts)
    lspconfig[server_name].setup(server_opts)
  end,
  ["lua_ls"] = function(server_name)
    local l_status_ok, lua_dev = pcall(require, "neodev")
    if not l_status_ok then
      return
    end

    lua_dev.setup {}

    local lua_opts = require "user.lsp.settings.sumneko_lua"
    server_opts = vim.tbl_deep_extend("force", lua_opts, server_opts)
    lspconfig[server_name].setup(server_opts)
  end,
  ["tailwindcss"] = function(server_name)
    local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    server_opts = vim.tbl_deep_extend("force", tailwindcss_opts, server_opts)
    lspconfig[server_name].setup(server_opts)
  end,
  ["eslint"] = function(server_name)
    local eslint_opts = vim.deepcopy(server_opts)
    eslint_opts["filetypes"] = {
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
    }

    lspconfig[server_name].setup(eslint_opts)
  end,
}
