local cmp = require "cmp"
local compare = require "cmp.config.compare"

cmp.setup {
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert {
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-c>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-l>"] = cmp.mapping(function(fallback)
      if vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    {
      name = "nvim_lsp",
      group_index = 1,
    },
    {
      name = "buffer",
      group_index = 1,
    },
    { name = "path", group_index = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.exact,
      compare.scopes,
      compare.locality,
      compare.offset,
      compare.kind,
      compare.recently_used,
      compare.score,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Normal,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = "rounded",
      winhighlight = "NormalFloat:Normal,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = false,
  },
}
