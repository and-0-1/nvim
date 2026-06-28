-- local statusline = require "user.statusline"
local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect", "fuzzy", "popup" },
  complete = ".,w,b,u,t,o",
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  showtabline = 1,
  smartcase = true,
  smartindent = true,
  autoindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  timeoutlen = 500,
  undofile = true,
  updatetime = 1000,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = false,
  relativenumber = true,
  -- statusline = statusline.full,
  laststatus = 1,
  signcolumn = "yes:3",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  listchars = "tab:→ ,trail:·,lead:·,extends:…,precedes:…,eol:↵",
  list = false,
  foldmethod = "marker",
  -- <C-n> as autocomplete menu trigger instead of <Tab>; wildchar wants a number
  wildchar = 14,
  wildmenu = true,
  wildoptions = "fuzzy,pum",
  grepprg = "rg --vimgrep --smart-case",
  grepformat = "%f:%l:%c:%m",
  winborder = "rounded",
  guicursor = "a:block-blinkon0,i-ci:ver25-blinkon0",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.path:append "**"
vim.opt.wildignore:append { "*/.git/*", "*/node_modules/*", "*/yarn-offline-cache/*" }

local sidebar_visible = true
local function toggle_sidebar()
  if sidebar_visible then
    -- vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "yes:5"
  else
    -- vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes:3"
  end

  sidebar_visible = not sidebar_visible
end

vim.api.nvim_create_user_command("ST", function()
  toggle_sidebar()
end, {})
