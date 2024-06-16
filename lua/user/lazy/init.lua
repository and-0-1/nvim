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
  { "numToStr/Comment.nvim", dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  } },
  "folke/todo-comments.nvim",

  -- UI
  {
    "stevearc/dressing.nvim",
    lazy = true,
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  "rcarriga/nvim-notify",
  "nvim-tree/nvim-web-devicons",
  "onsails/lspkind.nvim",
  "nvim-lualine/lualine.nvim",
  "kevinhwang91/nvim-bqf",
  "folke/zen-mode.nvim",

  -- Bookmarks
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
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
  "nvimtools/none-ls.nvim", -- for formatters and linters
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  "jay-babu/mason-nvim-dap.nvim",
  "b0o/SchemaStore.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  "mfussenegger/nvim-jdtls",

  -- Lua
  "folke/lua-dev.nvim",

  -- Telescope
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },
  -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  "windwp/nvim-ts-autotag",

  -- Git
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  "almo7aya/openingh.nvim",

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
    },
  },

  -- Testing
  -- {
  --   "vim-test/vim-test",
  --   init = function()
  --     vim.g["test#strategy"] = "toggleterm"
  --     vim.g["test#typescript#jest#test_command"] = "yarn test"
  --   end,
  -- },

  {
    "klen/nvim-test",
    init = function()
      require("nvim-test").setup {
        term = "toggleterm", -- a terminal to run ("terminal"|"toggleterm")
      }
      require("nvim-test.runners.jest"):setup {
        command = "yarn", -- a command to run the test runner
        args = { "test" }, -- default arguments
      }
    end,
  },

  -- auto close buffer if not used
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  -- {
  --   "iabdelkareem/csharp.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim", -- Required, automatically installs omnisharp
  --     "mfussenegger/nvim-dap",
  --     "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  --   },
  --   config = function()
  --     require("mason").setup() -- Mason setup must run before csharp
  --     require("csharp").setup()
  --   end,
  -- },
}
