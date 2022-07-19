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
    File = " ",
    Module = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = "%#CmpItemKindModule#" .. icons.kind.Method .. "%*" .. space,
    Property = "%#CmpItemKindModule#" .. icons.kind.Property .. "%*" .. space,
    Field = " ",
    Constructor = " ",
    Enum = "練",
    Interface = "練",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = "◩ ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = "ﳠ ",
    EnumMember = " ",
    Struct = "%#CmpItemKindModule#" .. icons.kind.Struct .. "%*" .. space,
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = " " .. icons.ui.ChevronRight .. " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
}
