-- ANSI mode: inherit from terminal palette
vim.opt.termguicolors = false

local function apply_overrides()
  -- local cursor_colors = {
  --   bg = "#40FF40",
  --   fg = "#000000",
  -- }
  -- local blueHighlight = {
  --   bg = "#0000af",
  --   fg = "#ffffff",
  -- }
  local hl = vim.api.nvim_set_hl
  -- Window bg blends with terminal
  hl(0, "Normal", { ctermfg = "NONE", ctermbg = "NONE" })
  hl(0, "NormalNC", { ctermfg = "NONE", ctermbg = "NONE" })
  -- Sidebar
  hl(0, "SignColumn", { ctermbg = "NONE" })
  hl(0, "LineNr", { ctermfg = 8, ctermbg = "NONE" })
  hl(0, "CursorLineNr", { ctermbg = "NONE", cterm = { bold = true } })
  hl(0, "FoldColumn", { ctermbg = "NONE" })
  hl(0, "WinSeparator", { ctermfg = 8, ctermbg = "NONE" })
  -- Status line: cterm=reverse swaps terminal fg/bg → portable across light/dark
  hl(0, "StatusLine", { ctermfg = "NONE", ctermbg = "NONE", cterm = { bold = true } })
  hl(0, "StatusLineNC", { ctermfg = 8, ctermbg = "NONE" })
  -- Floats and popups: blend with terminal, distinguish via border + selection
  hl(0, "NormalFloat", { ctermfg = "NONE", ctermbg = "NONE" })
  hl(0, "FloatBorder", { ctermfg = 8, ctermbg = "NONE" })
  hl(0, "Pmenu", { ctermfg = "NONE", ctermbg = "NONE" })
  hl(0, "PmenuSel", { ctermfg = "NONE", ctermbg = "NONE", cterm = { reverse = true } })
  hl(0, "PmenuSbar", { ctermbg = 8 })
  hl(0, "PmenuThumb", { ctermbg = 15 })
  -- Search: portable reverse, current match also bolded+underlined for distinction
  hl(0, "Search", { ctermfg = "NONE", ctermbg = "NONE", cterm = { reverse = true } })
  hl(0, "IncSearch", { ctermfg = "NONE", ctermbg = "NONE", cterm = { reverse = true, bold = true, underline = true } })
  hl(0, "CurSearch", { ctermfg = "NONE", ctermbg = "NONE", cterm = { reverse = true, bold = true, underline = true } })

  -- hl(0, "Visual", blueHighlight)
  -- hl(0, "CursorLine", blueHighlight)
  -- hl(0, "Cursor", cursor_colors)
end
--
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = apply_overrides })

apply_overrides()
--
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd.colorscheme "vim"
    vim.schedule(apply_overrides)
  end,
})
