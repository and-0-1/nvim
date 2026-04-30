local THRESHOLD = 256 * 1024 -- 256 KB
local MIN_SIZE_FOR_MINIFIED_CHECK = 32 * 1024

local group = vim.api.nvim_create_augroup("BigFile", { clear = true })

local function file_size(path)
  if not path or path == "" then
    return nil
  end
  local ok, stats = pcall(vim.uv.fs_stat, path)
  return ok and stats and stats.size or nil
end

local function is_minified(path)
  local fd = vim.uv.fs_open(path, "r", 438)
  if not fd then
    return false
  end
  local data = vim.uv.fs_read(fd, 8192, 0)
  vim.uv.fs_close(fd)
  return data and not data:find "\n" or false
end

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(ev)
    local path = vim.api.nvim_buf_get_name(ev.buf)
    local size = file_size(path)
    if not size then
      return
    end

    local big = size > THRESHOLD
    local minified = not big and size > MIN_SIZE_FOR_MINIFIED_CHECK and is_minified(path)
    if not (big or minified) then
      return
    end

    local label = minified and "minified" or "big"
    vim.notify(string.format("[bigfile] %s %s (%d KB) — features disabled", label, vim.fn.fnamemodify(path, ":t"), math.floor(size / 1024)))

    vim.b[ev.buf].large_buf = true
    vim.b[ev.buf].matchparen_disabled = 1
    vim.b[ev.buf].match_disable = 1
    vim.b[ev.buf].match_words = ""

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

