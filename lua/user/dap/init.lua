-- TODO: move configure and configure_exts to separate files
local function configure()
  local dap_breakpoint = {
    error = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "=>",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
local dapvt_ok, dapvt = pcall(require, "nvim-dap-virtual-text")

if not dap_ok or not dapui_ok or not dapvt_ok then
  return
end

local function configure_exts()
  dapvt.setup {
    commented = true,
  }
  dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "breakpoints", size = 0.2 },
          { id = "scopes", size = 0.4 },
          { id = "stacks", size = 0.4 },
          -- "watches",
        },
        size = 0.25, -- # columns
        position = "right",
      },
      {
        elements = {
          "repl",
          -- "console",
        },
        size = 0.25, -- % of total lines
        position = "bottom",
      },
    },
    controls = {
      -- Requires Neovim nightly (or 0.8 when released)
      enabled = true,
      -- Display controls in this element
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "倫",
        run_last = "ﰇ",
        terminate = "栗",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
    },
  } -- use default

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

require "user.dap.adapters"
require "user.dap.settings"
configure() -- Configuration
configure_exts() -- Extensions
require "user.dap.keymaps"
