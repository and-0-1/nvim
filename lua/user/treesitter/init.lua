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
    -- use_languagetree = true,
    enable = true, -- false will disable the whole extension
    -- additional_vim_regex_highlighting = true,
    disable = function(_lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 50000
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
