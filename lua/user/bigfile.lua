local THRESHOLD = 512 * 1024 -- 512 KB

local group = vim.api.nvim_create_augroup("BigFile", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(ev)
    local ok, stats = pcall(vim.uv.fs_stat, ev.match)
    if not ok or not stats or stats.size <= THRESHOLD then
      return
    end

    vim.b[ev.buf].large_buf = true

    vim.bo[ev.buf].swapfile = false
    vim.bo[ev.buf].undofile = false
    vim.bo[ev.buf].syntax = ""

    vim.opt_local.foldmethod = "manual"
    vim.opt_local.list = false
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    if vim.b[args.buf].large_buf then
      vim.lsp.buf_detach_client(args.buf, args.data.client_id)
    end
  end,
})
