local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

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
    formatting.stylua,
    formatting.shfmt,--[[ .with { extra_filetypes = { "zsh", "sh" } } ]]
    formatting.markdownlint,
    formatting.yamlfmt,
    formatting.gofmt,

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
    diagnostics.gitlint,
    diagnostics.markdownlint,
    diagnostics.yamllint,

    code_actions.proselint,
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
