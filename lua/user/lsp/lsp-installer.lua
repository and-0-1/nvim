local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  -- "emmet_ls",
  "html",
  "jdtls",
  "jsonls",
  "sumneko_lua",
  "tflint",
  "tsserver",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "intelephense",
  "prosemd_lsp",
  "rust_analyzer",
}

local settings = {
  ensure_installed = servers,
  -- automatic_installation = false,
  ui = {
    icons = {},
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
  max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts) or opts
  end

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts) or opts
  end

  if server == "sumneko_lua" then
    local l_status_ok, lua_dev = pcall(require, "lua-dev")
    if not l_status_ok then
      return
    end
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts) or opts
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.sumneko_lua.setup(luadev)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
