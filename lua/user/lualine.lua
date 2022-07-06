local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local mode = {
  "mode",
  padding = { left = 1, right = 1 },
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  -- colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  -- colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
  separator = "|",
  padding = 1,
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  -- colored = false,
}

local progress = {
  "progress",
  color = "SLProgress",
}

local current_signature = function()
  if not pcall(require, "lsp_signature") then
    return
  end
  local sig = require("lsp_signature").status_line(30)
  -- return sig.label .. "🐼" .. sig.hint
  return sig.hint
end

local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  separator = "|",
  padding = 1,
}

local location = {
  "location",
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
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    lualine_c = { { current_signature, cond = hide_in_width } },
    -- lualine_x = { diff, spaces, "encoding", filetype },
    lualine_x = { diff, spaces, filetype },
    lualine_y = { progress },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
