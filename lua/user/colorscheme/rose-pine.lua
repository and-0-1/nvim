local status_ok, rp = pcall(require, "rose-pine")
if not status_ok then
  return
end

rp.setup {
  -- variant = "moon",
  dim_nc_background = true,
  disable_background = false,
  disable_float_background = false,
  disable_italics = true,
  highlight_groups = {
    TelescopeBorder = { fg = "highlight_high", bg = "none" },
    TelescopeNormal = { bg = "none" },
    TelescopePromptNormal = { bg = "base" },
    TelescopeResultsNormal = { fg = "subtle", bg = "none" },
    TelescopeSelection = { fg = "text", bg = "base" },
    -- TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    NormalFloat = { bg = "base" },
    FloatBorder = { bg = "base", fg = "iris" },
    WhichkeyFloat = { bg = "base" },
    LspFloatWinNormal = { bg = "base" },
    FloatShadow = { bg = "base" },
    FloatShadowThrough = { bg = "base" },
    MatchParen = { fg = "love", bold = true },
    CursorLineNr = { fg = "pine", bold = true },
    LineNr = { fg = "subtle" },
  },
}

local colorscheme = "rose-pine"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
