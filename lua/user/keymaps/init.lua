local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

--Remap space as leader key
nnoremap("<Space>", "")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Center on scroll
nnoremap("gg", "ggzz")
nnoremap("G", "Gzz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Center on search
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
nnoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
nnoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- Insert --
-- Press jk fast to enter
-- inoremap("jk", "<ESC>")
-- inoremap("kj", "<ESC>")

-- Visual --
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- yank to system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')

-- delete to system clipboard
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
nnoremap("<leader>p", '"+p')
xnoremap("<leader>p", '"+P')

-- Visual Block --
-- Move text up and down
xnoremap("J", ":move '>+1<CR>gv-gv")
xnoremap("K", ":move '<-2<CR>gv-gv")

-- Custom
nnoremap("<esc><esc>", "<cmd>nohlsearch<cr>")

-- Open in browser
nnoremap("gx", [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

-- Quickfix toggle
nnoremap("<C-q>", ":lua require'user.functions'.qf_toggle()<cr>")

-- Buffer navigation
nmap("H", ":bprevious<cr>")
nmap("L", ":bnext<cr>")

-- Insert n amount of lines above/below
nnoremap("gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
nnoremap("go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Reselect latest changed, put, or yanked text
nnoremap("gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"')
-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
-- xnoremap("g/", "<esc>/\\%V")

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
-- xnoremap("*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
-- xnoremap("#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])
