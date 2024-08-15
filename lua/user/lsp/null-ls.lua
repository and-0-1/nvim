local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local cspell = require "cspell"

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettierd.with {
      condition = function(utils)
        return utils.root_has_file {
          ".prettierrc",
          "prettier.config.js",
          "prettier.config.cjs",
          ".prettierrc.json",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          ".prettierrc.js",
          ".prettierrc.cjs",
          ".prettierrc.toml",
        }
      end,
    },
    -- formatting.eslint_d,
    formatting.stylua,
    -- formatting.rustfmt,
    formatting.shfmt,--[[ .with { extra_filetypes = { "zsh", "sh" } } ]]
    -- formatting.fixjson,
    formatting.markdownlint,
    formatting.yamlfmt,
    formatting.gofmt,
    -- formatting.beautysh,
    -- formatting.phpcsfixer,
    -- formatting.deno_fmt.with {
    --   condition = function(utils)
    --     return utils.root_has_file {
    --       "deno.json",
    --       "deno.jsonc",
    --     }
    --   end,
    -- },

    -- diagnostics.eslint_d.with {
    --   condition = function(utils)
    --     return utils.root_has_file {
    --       ".eslintrc.js",
    --       ".eslintrc.cjs",
    --       ".eslintrc.yaml",
    --       ".eslintrc.yml",
    --       ".eslintrc.json",
    --     }
    --   end,
    -- },
    diagnostics.stylelint.with {
      extra_filetypes = { "javascriptreact" },
      condition = function(utils)
        return utils.root_has_file {
          ".stylelintrc",
          "stylelint.config.js",
          "stylelint.config.cjs",
          ".stylelintrc.json",
          ".stylelintrc.yaml",
          ".stylelintrc.yml",
          ".stylelintrc.js",
        }
      end,
    },
    diagnostics.zsh,
    -- diagnostics.shellcheck.with { extra_filetypes = { "bash", "zsh" } },
    diagnostics.gitlint,
    diagnostics.markdownlint,
    diagnostics.yamllint,
    cspell.diagnostics,
    -- diagnostics.luacheck,

    -- code_actions.eslint_d,
    -- code_actions.shellcheck,
    code_actions.proselint,
    cspell.code_actions,
  },
}

local mason_null_ok, mason_null = pcall(require, "mason-null-ls")

if not mason_null_ok then
  return
end

mason_null.setup {
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
}
