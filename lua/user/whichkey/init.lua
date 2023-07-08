local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

which_key.setup(wk_settings.setup)

local mappings = {

  -- TODO: maybe move these to lsp?
  l = {
    name = "LSP",
    f = {
      "<cmd>lua require('user.lsp.handlers').null_ls_format()<cr>",
      "Format",
    },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      "Prev Diagnostic",
    },
    -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    v = { '<cmd>lua require("lsp_lines").toggle()<cr>', "Toggle virtual text" },
  },
}


which_key.register(mappings, wk_settings.opts)
