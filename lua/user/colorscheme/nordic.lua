local status_ok, nordic = pcall(require, "nordic")
if not status_ok then
  return
end

local palette = require "nordic.colors"

nordic.setup {
  -- Telesccope custom configs.
  telescope = {
    -- Available styles: `classic`, `flat`.
    style = "flat",
  },
  -- Enable bold keywords.
  bold_keywords = true,
  -- Enable italicized comments.
  italic_comments = true,
  -- Enable general editor background transparency.
  transparent_bg = false,
  -- Override styling of any highlight group.
  -- (see next section for an example)
  override = {
    CmpItemAbbrMatch = { fg = palette.green.base, bold = true },
    LineNr = { fg = palette.gray5 },
  },
  cursorline = {
    bold = true,
    -- Available themes: 'dark', 'light'.
    theme = "light",
  },
}

nordic.load()
