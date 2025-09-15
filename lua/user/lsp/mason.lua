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
  "ts_ls",
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
    -- elseif server_name == "tailwindcss" then
    --   local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    --   server_opts = vim.tbl_deep_extend("force", tailwindcss_opts, server_opts)
    -- elseif server_name == "denols" then
    --   server_opts =
    --     vim.tbl_deep_extend("force", { root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc") }, server_opts)
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

-- mason_lsp.setup_handlers {
--   function(server_name)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["jsonls"] = function(server_name)
--     local jsonls_opts = {
--       settings = {
--         json = {
--           schemas = require("schemastore").json.schemas(),
--           validate = { enable = true },
--         },
--       },
--     }
--     server_opts = vim.tbl_deep_extend("force", jsonls_opts, server_opts)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["clangd"] = function(server_name)
--     server_opts = vim.tbl_deep_extend("force", {
--       capabilities = {
--         offsetEncoding = { "utf-8" },
--       },
--     }, server_opts)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["lua_ls"] = function(server_name)
--     local l_status_ok, lua_dev = pcall(require, "neodev")
--     if not l_status_ok then
--       return
--     end
--
--     lua_dev.setup {}
--
--     local lua_opts = require "user.lsp.settings.sumneko_lua"
--     server_opts = vim.tbl_deep_extend("force", lua_opts, server_opts)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["tailwindcss"] = function(server_name)
--     local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
--     server_opts = vim.tbl_deep_extend("force", tailwindcss_opts, server_opts)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["eslint"] = function(server_name)
--     local eslint_opts = vim.deepcopy(server_opts)
--     eslint_opts["filetypes"] = {
--       "javascript",
--       "javascriptreact",
--       "javascript.jsx",
--       "typescript",
--       "typescriptreact",
--       "typescript.tsx",
--       "vue",
--       "svelte",
--       "astro",
--       "graphql",
--     }
--
--     lspconfig[server_name].setup(eslint_opts)
--   end,
--   ["ts_ls"] = function(server_name)
--     local ts_opts = vim.deepcopy(server_opts)
--     ts_opts["root_dir"] = lspconfig.util.root_pattern "package.json"
--     ts_opts["single_file_support"] = false
--
--     lspconfig[server_name].setup(ts_opts)
--   end,
--   ["denols"] = function(server_name)
--     local denols_opts = vim.deepcopy(server_opts)
--     denols_opts["root_dir"] = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
--
--     lspconfig[server_name].setup(denols_opts)
--   end,
--   -- ["pylsp"] = function(server_name)
--   --   lspconfig[server_name].setup(server_opts)
--   -- end,
--   ["pyright"] = function(server_name)
--     lspconfig[server_name].setup(server_opts)
--   end,
--   ["ruff"] = function(server_name)
--     lspconfig[server_name].setup(server_opts)
--   end,
-- }
