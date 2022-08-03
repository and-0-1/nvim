local status_ok, zen = pcall(require, "true-zen")
if not status_ok then
  return
end

local lualine_ok, lualine = pcall(require, "lualine")

local api = vim.api

local opts = { noremap = true, silent = true, nowait = true }

-- api.nvim_set_keymap("n", "<leader>n", ":TZNarrow<CR>", opts)
api.nvim_set_keymap("v", "<leader>n", ":'<,'>TZNarrow<CR>", opts)
api.nvim_set_keymap("n", "<leader>nn", ":TZFocus<CR>", opts)
api.nvim_set_keymap("n", "<leader>nm", ":TZMinimalist<CR>", opts)
api.nvim_set_keymap("n", "<leader>nz", ":TZAtaraxis<CR>", opts)

zen.setup {
  modes = {
    ataraxis = {
      shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
      backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
      minimum_writing_area = { -- minimum size of main window
        width = 70,
        height = 44,
      },
      quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
      padding = { -- padding windows
        left = 30,
        right = 30,
        top = 0,
        bottom = 0,
      },
      open_callback = function()
        lualine.hide()
      end,
      close_callback = function()
        lualine.hide { unhide = true }
      end,
    },
    minimalist = {
      open_callback = function()
        lualine.hide()
      end,
      close_callback = function()
        lualine.hide { unhide = true }
      end,
    },
  },
  integrations = {
    tmux = true,
    kitty = {
      enabled = false,
      font = "+1",
    },
  },
  -- your config goes here
  -- or just leave it empty :)
}
