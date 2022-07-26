local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
  return
end

local get_hex = require("cokeline/utils").get_hex

local map = vim.api.nvim_set_keymap

map("n", "H", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "L", "<Plug>(cokeline-focus-next)", { silent = true })

vim.api.nvim_set_hl(0, "TabLineFill", { fg = get_hex("ColorColumn", "bg") })

cokeline.setup {
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
    end,
    bg = get_hex("ColorColumn", "bg"),
  },
  sidebar = {
    filetype = "NvimTree",
    components = {
      {
        text = "  NvimTree",
        bg = get_hex("NvimTreeNormal", "bg"),
        style = "bold",
      },
    },
  },
  components = {
    {
      text = " ",
      bg = get_hex("Normal", "bg"),
    },
    {
      text = "",
      fg = get_hex("ColorColumn", "bg"),
      bg = get_hex("Normal", "bg"),
    },
    {
      text = function(buffer)
        return buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = " ",
    },
    {
      text = function(buffer)
        return buffer.unique_prefix .. buffer.filename .. "  "
      end,
      style = function(buffer)
        return buffer.is_focused and "bold" or nil
      end,
    },
    -- {
    --   text = "",
    --   delete_buffer_on_left_click = true,
    -- },
    {
      text = "",
      fg = get_hex("ColorColumn", "bg"),
      bg = get_hex("Normal", "bg"),
    },
  },
}
