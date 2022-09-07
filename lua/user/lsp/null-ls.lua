local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
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
    formatting.eslint_d,
    -- formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    -- formatting.google_java_format,
    formatting.rustfmt,
    formatting.shfmt.with { extra_filetypes = { "zsh", "sh" } },
    formatting.fixjson,
    formatting.markdownlint,
    formatting.yamlfmt,

    diagnostics.eslint_d,
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
    diagnostics.shellcheck.with { extra_filetypes = { "bash, zsh" } },
    diagnostics.gitlint,
    diagnostics.markdownlint,
    diagnostics.yamllint,
    diagnostics.luacheck,

    code_actions.eslint_d,
    code_actions.shellcheck,
    code_actions.proselint,
    -- code_actions.refactoring,
  },
}
