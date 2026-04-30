require("blink.cmp").setup {
  keymap = {
    preset = "default",
    ["<C-c>"] = { "hide", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
  },
  completion = {
    menu = {
      auto_show = false,
      border = "rounded",
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "rounded" },
    },
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    ghost_text = { enabled = false },
  },
  sources = {
    default = { "lsp", "buffer", "path" },
  },
  signature = { enabled = true, window = { border = "rounded" } },
}
