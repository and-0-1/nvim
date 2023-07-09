-- Automatically install lzay
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
  -- General
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "akinsho/toggleterm.nvim",
  "NvChad/nvim-colorizer.lua",

  -- find and replace
  { "windwp/nvim-spectre", cmd = "Spectre" },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "markdown.mdx" }
    end,
    ft = { "markdown", "markdown.mdx" },
  },

  -- opening files from withing nvim terminal
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },

  -- Comment
  "numToStr/Comment.nvim",
  "folke/todo-comments.nvim",

  -- UI
  {
    "stevearc/dressing.nvim",
    lazy = true,
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  "folke/which-key.nvim",
  "rcarriga/nvim-notify",
  "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "kevinhwang91/nvim-bqf",
  "folke/zen-mode.nvim",

  -- Bookmarks
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Text navigation
  "nacro90/numb.nvim",

  -- Word manipulation enhacements
  -- "tpope/vim-surround",
  {
    "kylechui/nvim-surround",
    config = true,
  },
  "tpope/vim-repeat",
  "tpope/vim-abolish",

  -- File navigation
  "kyazdani42/nvim-tree.lua",

  -- Colorschemes
  -- "folke/tokyonight.nvim",
  { "rose-pine/neovim", name = "rose-pine" },

  -- cmp plugins
  "hrsh7th/nvim-cmp",

  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "jayp0521/mason-null-ls.nvim",
  "jay-babu/mason-nvim-dap.nvim",
  "b0o/SchemaStore.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  -- copilot
  -- TODO: replace with codeium once this expires =(
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            rust = false,
            yaml = false,
            help = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
        }
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup {
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      }
    end,
  },

  -- Lua
  "folke/lua-dev.nvim",

  -- Telescope
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "mrjones2014/nvim-ts-rainbow",
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  "windwp/nvim-ts-autotag",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- TMUX
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },

  -- File types
  "jxnblk/vim-mdx-js",

  -- JSON utils
  "gennaro-tedesco/nvim-jqx",

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      { "jbyuki/one-small-step-for-vimkind" },
      "which-key.nvim",
    },
  },

  -- Testing
  {
    "vim-test/vim-test",
    init = function()
      vim.g["test#strategy"] = "toggleterm"
    end,
  },

  -- auto close buffer if not used
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
