local status_ok, zen = pcall(require, "true-zen")
if not status_ok then
  return
end

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
    },
    minimalist = {
      options = { -- options to be disabled when entering Minimalist mode
        number = true,
        relativenumber = true,
        showtabline = 0,
        signcolumn = "yes",
        -- statusline = "%#Normal# --Minimalist mode--",
        cmdheight = 1,
        -- laststatus = 3,
        showcmd = true,
        showmode = false,
        ruler = false,
        numberwidth = 1,
      },
    },
  },
  integrations = {
    tmux = true,
    kitty = {
      enabled = false,
      font = "+0",
    },
    lualine = true,
  },
  -- your config goes here
  -- or just leave it empty :)
}

require "user.true-zen.keymaps"
