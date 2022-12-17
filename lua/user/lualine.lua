local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
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

local grapple = {
  function()
    local ok, grapple = pcall(require, "grapple")
    if not ok then
      return
    end
    local key = grapple.key()
    return " [" .. key .. "]"
  end,
  cond = function()
    local ok, grapple = pcall(require, "grapple")
    if not ok then
      return false
    end
    return grapple.exists()
  end,
  separator = {
    right = halfcircle_right,
  },
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics, grapple },
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
