-- Automatically install lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
return lazy.setup {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  spec = {
    -- Word manipulation enhancements
    {
      "kylechui/nvim-surround",
      config = true,
    },
    "tpope/vim-repeat",
    "tpope/vim-abolish",

    -- LSP
    { "neovim/nvim-lspconfig" }, -- enable LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "stevearc/conform.nvim", -- formatters
    "b0o/SchemaStore.nvim",
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    -- "mfussenegger/nvim-jdtls",

    -- Lua
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- Git
    -- "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- Colorscheme
    -- {
    --   "stevedylandev/ansi-nvim",
    --   lazy = false,
    --   priority = 1000,
    -- },
  },
}
