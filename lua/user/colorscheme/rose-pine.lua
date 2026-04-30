require("rose-pine").setup {
  variant = "moon",
  -- dim_nc_background = false,
  disable_background = true,
  disable_float_background = true,
  --
  styles = {
    italic = false,
  },
  --
  highlight_groups = {
    --   Whitespace = { fg = "overlay" },
    --   NonText = { fg = "overlay" },
    --   CursorLine = { bg = "surface" },
    -- ["@variable"] = { fg = "text", italic = false },
    -- ["@variable.parameter"] = { fg = "iris", italic = false },
    -- ["@property"] = { fg = "foam", italic = false },
    --   Winbar = { fg = "iris", bg = "base" },
    --   TelescopeBorder = { fg = "highlight_high", bg = "none" },
    --   TelescopeNormal = { bg = "none" },
    --   TelescopePromptNormal = { bg = "base" },
    --   TelescopeResultsNormal = { fg = "subtle", bg = "none" },
    --   TelescopeSelection = { fg = "text", bg = "base" },
    --   -- TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    --   NormalFloat = { bg = "base" },
    FloatBorder = { fg = "iris" },
    --   WhichkeyFloat = { bg = "base" },
    --   LspFloatWinNormal = { bg = "base" },
    --   FloatShadow = { bg = "base" },
    --   FloatShadowThrough = { bg = "base" },
    --   MatchParen = { fg = "love", bold = true },
    --   CursorLineNr = { fg = "pine", bold = true },
    --   LineNr = { fg = "subtle" },
  },
}

vim.cmd "colorscheme rose-pine"
