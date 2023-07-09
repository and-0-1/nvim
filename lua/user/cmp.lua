local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local compare = require "cmp.config.compare"

local check_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

local icons = require "user.icons"

local kind_icons = icons.kind

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert {
    ["<C-j>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end),
    ["<C-k>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
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
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "n",
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "n",
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  sources = {
    {
      name = "nvim_lsp",
      group_index = 1,
    },
    { name = "luasnip", group_index = 1 },
    {
      name = "buffer",
      group_index = 1,
    },
    -- Copilot Source
    { name = "copilot", group_index = 2 },

    { name = "nvim_lua", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "emoji", group_index = 3 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.exact,
      compare.offset,
      compare.scopes,
      compare.locality,
      compare.kind,
      require("copilot_cmp.comparators").prioritize,
      require("copilot_cmp.comparators").score,
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
    ghost_text = true,
  },
}

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  mapping = cmp.mapping.preset.cmdline {},
})
