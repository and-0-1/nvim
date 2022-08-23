local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("_packer_sync_on_save", { clear = true }),
  pattern = { "*/plugins/init.lua" },
  callback = function()
    vim.cmd [[ source %]]
    require("packer").sync()
  end,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 20,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

require "user.plugins.keymaps"

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin management
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "lewis6991/impatient.nvim"

  -- General
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim"
  use "NvChad/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- Comment
  use "numToStr/Comment.nvim"
  -- use "folke/todo-comments.nvim"
  use "B4mbus/todo-comments.nvim"

  -- UI
  use "stevearc/dressing.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "rcarriga/nvim-notify"
  use "tversteeg/registers.nvim"
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use "kyazdani42/nvim-web-devicons"
  -- use "andymass/vim-matchup"
  use "nvim-lualine/lualine.nvim"
  use "kevinhwang91/nvim-bqf"
  use { "Pocco81/true-zen.nvim", branch = "dev" }

  -- Bookmarks
  -- use "MattesGroeger/vim-bookmarks"
  use "ThePrimeagen/harpoon"

  -- Text navigation
  use "ggandor/lightspeed.nvim"
  use "nacro90/numb.nvim"

  -- Word manipulation enhacements
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-abolish"
  use "monaqa/dial.nvim"

  -- File navigation
  use "kyazdani42/nvim-tree.lua"
  use "tamago324/lir.nvim"

  -- Buffer management
  -- use "akinsho/bufferline.nvim"
  -- use {
  --   "noib3/nvim-cokeline",
  --   requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
  -- }

  -- Colorschemes
  use "folke/tokyonight.nvim"
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  use "rose-pine/neovim"
  use "rebelot/kanagawa.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"

  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use "lukas-reineke/cmp-rg"
  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use {
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn compile",
  }

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"
  use "rmagatti/goto-preview"
  use "b0o/SchemaStore.nvim"
  -- use "folke/trouble.nvim"
  use "RRethy/vim-illuminate"
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  use "lvimuser/lsp-inlayhints.nvim"
  -- use "simrat39/inlay-hints.nvim"
  use "j-hui/fidget.nvim"

  -- Lua
  use "folke/lua-dev.nvim"
  -- Java
  -- use "mfussenegger/nvim-jdtls"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "https://github.com/rhysd/conflict-marker.vim"

  -- TMUX
  use "christoomey/vim-tmux-navigator"

  -- File types
  use "jxnblk/vim-mdx-js"

  -- Debugging
  -- TODO: i like this approach; apply to other plugins
  use {
    "mfussenegger/nvim-dap",
    opt = true,
    event = "BufReadPre",
    module = { "dap" },
    wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
