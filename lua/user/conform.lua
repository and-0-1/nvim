local conform = require "conform"

local function has_prettier_config(bufnr)
  local found = vim.fs.find({
    ".prettierrc",
    "prettier.config.js",
    "prettier.config.cjs",
    ".prettierrc.json",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
  }, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })
  return #found > 0
end

vim.g.format_on_save = true

local prettier_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "yaml",
  "css",
  "scss",
  "html",
  "graphql",
  "vue",
  "svelte",
  "astro",
}

local formatters_by_ft = {
  lua = { "stylua" },
  sh = { "shfmt" },
  bash = { "shfmt" },
  zsh = { "shfmt" },
  markdown = { "markdownlint" },
}
for _, ft in ipairs(prettier_filetypes) do
  formatters_by_ft[ft] = { "prettierd" }
end

conform.setup {
  formatters_by_ft = formatters_by_ft,
  formatters = {
    prettierd = {
      condition = function(_, ctx)
        return has_prettier_config(ctx.buf)
      end,
    },
  },
  format_on_save = function()
    if not vim.g.format_on_save then
      return
    end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
}

vim.api.nvim_create_user_command("FormatToggle", function()
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify("format_on_save = " .. tostring(vim.g.format_on_save))
end, {})

vim.api.nvim_create_user_command("Format", function()
  conform.format { async = true, lsp_format = "fallback" }
end, {})
