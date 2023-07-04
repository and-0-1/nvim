local M = {}

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
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
  -- local filename = vim.fn.expand "%:t"
  local filename = vim.fn.expand "%:p:h:t" .. "/" .. "%t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.functions"

  if not f.isempty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return "%#Winbar#" .. " " .. "%#" .. hl_group .. "#" .. file_icon .. " " .. "%#Winbar#" .. filename
  end
end

local excludes = function()
  -- vim.notify "fetching winbar..."
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

  if not f.isempty(value) and f.get_buf_option "mod" then
    local mod = "%#LineNr#" .. require("user.icons").ui.Circle .. "%*"
    value = value .. " " .. mod
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd({
      "BufEnter",
      "TextChanged",
      "InsertLeave",
      "BufWritePost",
      "WinEnter",
      "BufWinEnter",
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
end

return M
