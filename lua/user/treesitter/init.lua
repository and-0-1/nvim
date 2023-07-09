local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all", -- one of "all" or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
    disable_virtual_text = true,
    -- include_match_words = false
  },
  highlight = {
    -- use_languagetree = true,
    enable = true, -- false will disable the whole extension
    -- disable = { "css", "html" }, -- list of language that will be disabled
    disable = { "css", "markdown" }, -- list of language that will be disabled
    -- additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true, --[[ disable = { "python", "css" } ]]
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
    disable = { "xml" },
  },
  rainbow = {
    enable = false,
    -- disable = { "html" },
  },
  playground = {
    enable = false,
  },
  -- TODO: look into this in more detail; navigating with treesitter objects; add good mappings
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [")f"] = "@function.outer",
        [")b"] = "@block.outer",
        [")c"] = "@class.outer",
        [")a"] = "@parameter.outer",
        [")l"] = "@loop.outer",
        -- ["]f"] = "@function.inner",
        -- ["]b"] = "@block.inner",
        -- ["]c"] = "@class.inner",
        -- ["]a"] = "@parameter.inner",
        -- ["]l"] = "@loop.inner",
      },
      goto_next_end = {
        [")F"] = "@function.outer",
        [")B"] = "@block.outer",
        [")C"] = "@class.outer",
        [")A"] = "@parameter.outer",
        [")L"] = "@loop.outer",
        -- ["]F"] = "@function.inner",
        -- ["]B"] = "@block.inner",
        -- ["]C"] = "@class.inner",
        -- ["]A"] = "@parameter.inner",
        -- ["]L"] = "@loop.inner",
      },
      goto_previous_start = {
        ["(f"] = "@function.outer",
        ["(b"] = "@block.outer",
        ["(c"] = "@class.outer",
        ["(a"] = "@parameter.outer",
        ["(l"] = "@loop.outer",
        -- ["[f"] = "@function.inner",
        -- ["[b"] = "@block.inner",
        -- ["[c"] = "@class.inner",
        -- ["[a"] = "@parameter.inner",
        -- ["[l"] = "@loop.inner",
      },
      goto_previous_end = {
        ["(F"] = "@function.outer",
        ["(B"] = "@block.outer",
        ["(C"] = "@class.outer",
        ["(A"] = "@parameter.outer",
        ["(L"] = "@loop.outer",
        -- ["[F"] = "@function.inner",
        -- ["[B"] = "@block.inner",
        -- ["[C"] = "@class.inner",
        -- ["[A"] = "@parameter.inner",
        -- ["[L"] = "@loop.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}

