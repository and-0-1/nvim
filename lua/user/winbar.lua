local M = {}

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "",
  "DressingSelect",
  "DressingInput",
  "dap-repl",
}

M.get_filename = function()
  local filepath = vim.fn.expand "%"
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.functions"
  local max_folders_to_show = 2

  local folders = {}

  for match in string.gmatch(filepath, "/?%w*/") do
    table.insert(folders, match)
  end

  local path = ""

  for i = #folders, #folders - (max_folders_to_show - 1), -1 do
    if folders[i] then
      path = folders[i] .. path
    end
  end

  -- if #folders > max_folders_to_show then
  --   path = " …" .. path
  -- end

  path = path .. filename

  if not f.isempty(filepath) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filepath, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. " " .. "%#Normal#" .. path
    -- return "%#Winbar#" .. " " .. "%#" .. hl_group .. "#" .. file_icon .. " " .. "%#Winbar#" .. filename
    -- return "%#Winbar#" .. file_icon .. " " .. filename
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require "user.functions"
  local value = M.get_filename()

  -- if not f.isempty(value) and f.get_buf_option "mod" then
  --   local mod = "%#LineNr#" .. require("user.icons").ui.Circle .. "%*"
  --   value = value .. " " .. mod
  -- end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  vim.api.nvim_create_autocmd({
    "BufEnter",
    -- "TextChanged",
    -- "InsertLeave",
    -- "BufWritePost",
    -- "WinEnter",
    -- "BufWinEnter",
  }, {
    group = "_winbar",
    pattern = { "*.*" },
    callback = function()
      local in_floating_window, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
      if not in_floating_window then
        M.get_winbar()
      end
    end,
  })
end

return M
