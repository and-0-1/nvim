local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect", "fuzzy" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  -- mouse = "a", -- allow the mouse to be used in neovim
  -- pumheight = 10, -- pop up menu height
  showtabline = 1, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true,
  autoindent = true,
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 1000, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  statusline = "%#Title#%<%f %#MoreMsg# %h%w%m%r%=%-14.(%l,%c%V%) %P",
  laststatus = 2,
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = true, -- wrap lines
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
  -- listchars = "tab:→ ,trail:·,eol:↲,extends:…,precedes:…",
  listchars = "tab:→ ,trail:·,lead:·,extends:…,precedes:…,eol:↵",
  list = false,
  foldmethod = "marker",
  wildchar = vim.fn.char2nr "", -- change autocomplete menu trigger from Tab -> Ctrl - n; wildchar only accepts number in lua, so we transform char to number
}

-- vim.opt.fillchars = vim.opt.fillchars + "vertleft: "
-- vim.opt.fillchars = vim.opt.fillchars + "vertright: "

-- vim.opt.fillchars = vim.opt.fillchars + "eob: "
-- vim.opt.fillchars:append {
--   stl = " ",
-- }

-- vim.opt.shortmess:append "c"

-- vim.g.netrw_keepdir = 0
-- vim.g.netrw_liststyle = 3 -- show tree style by default

for k, v in pairs(options) do
  vim.opt[k] = v
end
