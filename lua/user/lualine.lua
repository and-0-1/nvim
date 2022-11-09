local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local theme
-- NOTE: mellow overrides
local mellow_ok = pcall(require, "mellow")
if mellow_ok then
  local mellow_colors = require("mellow.colors").dark
  local lualine_mellow = require "lualine.themes.mellow"
  lualine_mellow.normal.c.bg = mellow_colors.bg
  theme = lualine_mellow
end

local halfcircle_right = ""
local halfcircle_left = ""

local mode = {
  "mode",
  padding = { left = 1, right = 1 },
  separator = {
    right = halfcircle_right,
  },
}

local hide_in_width = function()
  return vim.o.columns > 80
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  update_in_insert = false,
  always_visible = true,
  separator = {
    right = halfcircle_right,
  },
}

local diff = {
  "diff",
  -- colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  -- cond = hide_in_width,
  separator = "|",
  padding = {
    right = 1,
  },
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

local branch = {
  "branch",
  icons_enabled = true,
  -- icon = "",
  -- icon = "",
  -- colored = false,
}

local progress = {
  "progress",
  color = "SLProgress",
}

local spaces = {
  function()
    return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  separator = "|",
  padding = 1,
  cond = hide_in_width,
}

local location = {
  "location",
  separator = {
    left = halfcircle_left,
  },
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = theme or "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics },
    lualine_c = {
      --[[ current_signature ]]
    },
    lualine_x = { diff, spaces, filetype },
    lualine_y = { progress },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
