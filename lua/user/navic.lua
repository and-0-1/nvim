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
    File = "%#CmpItemKindFile#" .. "" .. "%*" .. space,
    Module = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
    Namespace = "%#CmpItemKindModule#" .. "" .. "%*" .. space,
    Package = "%#CmpItemKindPackage#" .. "" .. "%*" .. space,
    Class = "%#CmpItemKindClass#" .. "" .. "%*" .. space,
    Method = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. space,
    Property = "%#CmpItemKindProperty#" .. icons.kind.Property .. "%*" .. space,
    Field = "%#CmpItemKindField#" .. "" .. "%*" .. space,
    Constructor = "%#CmpItemKindConstructor#" .. "" .. "%*" .. space,
    Enum = "%#CmpItemKindEnum#" .. "練" .. "%*",
    Interface = "%#CmpItemKindInterface#" .. "練" .. "%*",
    Function = "%#CmpItemKindFunction#" .. "" .. "%*" .. space,
    Variable = "%#CmpItemKindVariable#" .. "" .. "%*" .. space,
    Constant = "%#CmpItemKindConstant#" .. "" .. "%*" .. space,
    String = "%#CmpItemKindString#" .. icons.type.String .. "%*" .. space,
    Number = "%#CmpItemKindNumber#" .. icons.type.Number .. "%*" .. space,
    Boolean = "%#CmpItemKindBoolean#" .. "◩" .. "%*" .. space,
    Array = "%#CmpItemKindArray#" .. "" .. "%*" .. space,
    Object = "%#CmpItemKindObject#" .. icons.type.Object .. "%*" .. space,
    Key = "%#CmpItemKindKey#" .. icons.kind.Keyword .. "%*" .. space,
    Null = "%#CmpItemKindNull#" .. "ﳠ" .. "%*" .. space,
    EnumMember = "%#CmpItemKindEnumMember#" .. icons.kind.Enum .. "%*" .. space,
    Struct = "%#CmpItemKindStruct#" .. icons.kind.Struct .. "%*" .. space,
    Event = "%#CmpItemKindEvent#" .. icons.kind.Event .. "%*" .. space,
    Operator = "%#CmpItemKindOperator#" .. icons.kind.Operator .. "%*" .. space,
    TypeParameter = "%#CmpItemKindTypeParameter#" .. icons.kind.TypeParameter .. "%*" .. space,
  },
  highlight = false,
  separator = " " .. icons.ui.ChevronRight .. " ",
  depth_limit = 3,
  depth_limit_indicator = "..",
}
