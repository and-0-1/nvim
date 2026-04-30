local Remap = require "user.keymaps.bind"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
-- local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

--Remap space as leader key
nnoremap("<Space>", "")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert --
-- Press jk fast to enter
-- inoremap("jk", "<ESC>")
-- inoremap("kj", "<ESC>")

-- Visual --
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Visual Block --
-- Move text up and down
xnoremap("J", ":move '>+1<CR>gv-gv")
xnoremap("K", ":move '<-2<CR>gv-gv")

-- Buffer navigation
-- nmap("H", ":bprevious<cr>")
-- nmap("L", ":bnext<cr>")

-- Insert n amount of lines above/below
nnoremap("gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
nnoremap("go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Normal <leader> + key
-- general
nnoremap("<leader>c", "<cmd>bnext | bd#<CR>")
nnoremap("<leader>x", "<cmd>Ex<cr>")

-- In the case where no lsp is attached
nmap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
