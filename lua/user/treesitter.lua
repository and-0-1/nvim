local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.motoko = "typescript"

configs.setup {
  ensure_installed = "all", -- one of "all" or a list of languages
  sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
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
  indent = { enable = true, disable = { "python", "css" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
    disable = { "xml" },
  },
  rainbow = {
    enable = true,
    -- colors = {
    --   "Gold",
    --   "Orchid",
    --   "DodgerBlue",
    --   -- "Cornsilk",
    --   -- "Salmon",
    --   -- "LawnGreen",
    -- },
    disable = { "html" },
  },
  playground = {
    enable = false,
  },
  -- TODO: look into this in more detail; navigating with treesitter objects; add good mappings
  -- textobjects = {
  --   select = {
  --     enable = true,
  --
  --     -- Automatically jump forward to textobj, similar to targets.vim
  --     lookahead = true,
  --
  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --       ["aa"] = "@parameter.outer",
  --       ["ia"] = "@parameter.inner",
  --     },
  --   },
  --   move = {
  --     enable = true,
  --     set_jumps = true, -- whether to set jumps in the jumplist
  --     goto_next_start = {
  --       ["]m"] = "@function.outer",
  --       ["]]"] = "@class.outer",
  --     },
  --     goto_next_end = {
  --       ["]M"] = "@function.outer",
  --       ["]["] = "@class.outer",
  --     },
  --     goto_previous_start = {
  --       ["[m"] = "@function.outer",
  --       ["[["] = "@class.outer",
  --     },
  --     goto_previous_end = {
  --       ["[M"] = "@function.outer",
  --       ["[]"] = "@class.outer",
  --     },
  --   },
  -- },
}
