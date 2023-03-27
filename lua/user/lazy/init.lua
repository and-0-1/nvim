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
  "moll/vim-bbye",
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
  -- {
  --   "liangxianzhe/floating-input.nvim",
  --   init = function()
  --     require("floating-input").setup()
  --   end,
  -- },
  "goolord/alpha-nvim",
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
  "ggandor/leap.nvim",
  "nacro90/numb.nvim",

  -- Word manipulation enhacements
  -- "tpope/vim-surround",
  {
    "kylechui/nvim-surround",
    config = true,
  },
  "tpope/vim-repeat",
  "tpope/vim-abolish",
  "monaqa/dial.nvim",

  -- File navigation
  "kyazdani42/nvim-tree.lua",
  "tamago324/lir.nvim",

  -- Colorschemes
  "folke/tokyonight.nvim",
  { "rose-pine/neovim", name = "rose-pine" },
  "rebelot/kanagawa.nvim",
  "andoni0305/mellow.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
  "projekt0n/github-nvim-theme",
  "savq/melange-nvim",
  "AlexvZyl/nordic.nvim",

  -- cmp plugins
  "hrsh7th/nvim-cmp",

  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lua",
  "lukas-reineke/cmp-rg",

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  -- {
  --   "dsznajder/vscode-es7-javascript-react-snippets",
  --   build = "yarn install --frozen-lockfile && yarn compile",
  -- },

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "jayp0521/mason-null-ls.nvim",
  "jay-babu/mason-nvim-dap.nvim",
  "simrat39/symbols-outline.nvim",
  "ray-x/lsp_signature.nvim",
  "rmagatti/goto-preview",
  "b0o/SchemaStore.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  -- {
  --   "tzachar/local-highlight.nvim",
  --   -- TODO: move this into it's own file
  --   config = function()
  --     require("local-highlight").setup {}
  --     vim.api.nvim_create_autocmd("BufRead", {
  --       pattern = { "*.*" },
  --       callback = function(data)
  --         require("local-highlight").attach(data.buf)
  --       end,
  --     })
  --   end,
  -- },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("))", "next")
      map("((", "prev")

      -- also set it after loading ftplugins, since a lot overwrite (( and ))
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("))", "next", buffer)
          map("((", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "))", desc = "Next Reference" },
      { "((", desc = "Prev Reference" },
    },
  },
  -- "lvimuser/lsp-inlayhints.nvim",
  --  "simrat39/inlay-hints.nvim"
  -- "j-hui/fidget.nvim",

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
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

  -- codeium
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {}
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
  "https://github.com/rhysd/conflict-marker.vim",
  "almo7aya/openingh.nvim",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

  -- TMUX
  "christoomey/vim-tmux-navigator",

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
    "klen/nvim-test",
    config = function()
      require("nvim-test").setup()
      -- require("nvim-test.runners.jest"):setup {
      --   command = "yarn test", -- a command to run the test runner
      --   file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$", -- determine whether a file is a testfile
      --   find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" }, -- find testfile for a file
      -- }
    end,
  },

  -- Note-taking
  "phaazon/mind.nvim",

  -- console log generator
  "PatschD/zippy.nvim",
}
