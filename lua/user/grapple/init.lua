local ok, grapple = pcall(require, "grapple")
if not ok then
  vim.notify "grapple load issue"
  return
end

grapple.setup {
  ---@type "debug" | "info" | "warn" | "error"
  log_level = "warn",

  ---Can be either the name of a builtin scope resolver,
  ---or a custom scope resolver
  ---@type string | Grapple.ScopeResolver
  scope = "git",

  ---Window options used for the popup menu
  popup_options = {
    relative = "editor",
    width = 60,
    height = 12,
    style = "minimal",
    focusable = false,
    border = "single",
  },

  integrations = {
    ---Support for saving tag state using resession.nvim
    resession = false,
  },
}

-- Create a fallback scope resolver that first tries to use the LSP for a scope
-- path, then looks for a ".git" repository, and finally falls back on using
-- the initial working directory that neovim was started in
require("grapple.scope").fallback {
  require("grapple").resolvers.lsp_fallback,
  require("grapple").resolvers.static,
}

require "user.grapple.keymaps"
