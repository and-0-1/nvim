local M = {}

local function bind(mode, default_opts)
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", default_opts or {}, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.nmap = bind("n", { remap = true })
M.nnoremap = bind "n"
M.vnoremap = bind "v"
M.xnoremap = bind "x"
M.inoremap = bind "i"

return M
