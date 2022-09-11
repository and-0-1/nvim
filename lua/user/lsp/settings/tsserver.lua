local inlayHints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

return {
  settings = {
    javascript = {
      suggest = {
        autoImports = true,
      },
      inlayHints = inlayHints,
    },
    typescript = {
      suggest = {
        autoImports = true,
      },
      inlayHints = inlayHints,
    },
  },
}
