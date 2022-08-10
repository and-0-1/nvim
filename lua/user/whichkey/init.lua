local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_settings = require "user.whichkey.settings"

local mappings = {
  e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  w = { "<cmd>w<CR>", "Write" },
  h = { "<cmd>nohlsearch<CR>", "No HL" },
  q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
  zz = { '<cmd>lua require("user.functions").save_and_exit()<CR>', "Save and exit" },
  ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
  c = { "<cmd>Bdelete!<CR>", "Close Buffer" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  o = {
    name = "Options",
    w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
    r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
    l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
    s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
    t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
  },

  ["-"] = { "<cmd>split<cr>", "HSplit" },
  ["|"] = { "<cmd>vsplit<cr>", "VSplit" },

  r = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = {
      "<cmd>Gitsigns undo_stage_hunk<cr>",
      "Undo Stage Hunk",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
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
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    v = { '<cmd>lua require("lsp_lines").toggle()<cr>', "Toggle virtual text" },
    h = { '<cmd>lua require("lsp-inlayhints").toggle()<cr>', "Toggle hints" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    t = { "<cmd>ToggleTerm<cr>", "Terminal" },
    p = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  },

  N = {
    ":e ~/Notes/<cr>",
    "Notebook",
  },
}

local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}

which_key.setup(wk_settings.setup)
which_key.register(mappings, wk_settings.opts)
which_key.register(vmappings, wk_settings.vopts)
