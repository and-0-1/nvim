local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local icons = require "user.icons"

telescope.setup {
  defaults = {
    prompt_prefix = icons.ui.Telescope .. " ",
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    -- selection_caret = " ",
    path_display = { "truncate" },
    file_ignore_patterns = { ".git/", "node_modules/", "yarn-offline-cache/" },
    winblend = 0,
    -- layout_strategy = "vertical",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
      },

      n = {
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      layout_config = {
        width = 0.6,
      },
    },
    git_files = {
      theme = "dropdown",
      layout_config = {
        width = 0.6,
      },
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
    },
    lsp_references = {
      theme = "dropdown",
    },
    lsp_definitions = {
      theme = "dropdown",
    },
    lsp_implementations = {
      theme = "dropdown",
    },
    lsp_document_symbols = {
      theme = "dropdown",
    },
    grapple = {
      theme = "dropdown",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

-- Load extension configs and bindings
require("telescope").load_extension "fzf"
require("telescope").load_extension "grapple"

-- Keymaps
local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap

nnoremap("<leader>b", "<cmd>Telescope buffers<CR>")
nnoremap("<C-p>", "<cmd>lua require('user.telescope.finders').project_files()<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ft", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fw", "<cmd>Telescope grep_string<cr>")
nnoremap("<leader>fl", "<cmd>Telescope resume<cr>")
