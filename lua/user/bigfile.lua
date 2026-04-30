local THRESHOLD = 512 * 1024 -- 512 KB

local group = vim.api.nvim_create_augroup("BigFile", { clear = true })

local function file_size(path)
  if not path or path == "" then
    return nil
  end
  local ok, stats = pcall(vim.uv.fs_stat, path)
  return ok and stats and stats.size or nil
end

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(ev)
    local path = vim.api.nvim_buf_get_name(ev.buf)
    local size = file_size(path)
    if not size or size <= THRESHOLD then
      return
    end

    vim.notify(string.format("[bigfile] %s (%d KB) — features disabled", vim.fn.fnamemodify(path, ":t"), math.floor(size / 1024)))

    vim.b[ev.buf].large_buf = true
    vim.b[ev.buf].matchparen_disabled = 1

    vim.bo[ev.buf].swapfile = false
    vim.bo[ev.buf].undofile = false
    vim.bo[ev.buf].syntax = ""
    vim.bo[ev.buf].matchpairs = ""
    vim.bo[ev.buf].synmaxcol = 200

    vim.opt_local.foldmethod = "manual"
    vim.opt_local.list = false
    vim.opt_local.spell = false
    vim.opt_local.cursorline = false
    vim.opt_local.relativenumber = false
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
