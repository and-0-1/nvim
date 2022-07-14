local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  return
end

local icons = require "user.icons"

local space = ""

if vim.fn.has "mac" == 1 then
  space = " "
end

navic.setup {
  icons = {
    Class = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. space, -- Classes and class-like objects
    Function = "%#CmpItemKindFunction#" .. icons.kind.Function .. "%*" .. space, -- Functions
    Method = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. space, -- Methods (functions inside class-like objects)
    Object = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space, -- Containers (example: lua tables)
    Array = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
    Null = "%#CmpItemKindField#" .. icons.kind.Field .. "%*" .. space,
    Boolean = "%#CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. space,
    Number = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
    String = "%#CmpItemKindValue#" .. icons.type.String .. "%*" .. space,
    Module = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
  },
  highlight = true,
  separator = " " .. icons.ui.ChevronRight .. " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
}
