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
    tsserver = {
      javascript = {
        format = {
          enable = false,
        },
        implicitProjectConfig = {
          checkJs = true,
        },
        suggest = {
          autoImports = true,
        },
        inlayHints = inlayHints,
      },
      ["js/ts"] = {
        implicitProjectConfig = {
          checkJs = true,
        },
      },
      typescript = {
        suggest = {
          autoImports = true,
        },
        inlayHints = inlayHints,
      },
    },
  },
}
