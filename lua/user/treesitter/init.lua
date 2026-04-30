---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup {
  auto_install = false,
  ensure_installed = "all", -- one of "all" or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "ipkg" }, -- List of parsers to ignore installing
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
    disable_virtual_text = true,
    -- include_match_words = false
  },
  highlight = {
    enable = true,
    disable = function(_lang, bufnr)
      return vim.b[bufnr].large_buf == true
        or vim.api.nvim_buf_line_count(bufnr) > 50000
    end,
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
    disable = { "xml" },
  },
  rainbow = {
    enable = false,
  },
  playground = {
    enable = false,
  },
}
