local status_ok, smooth_cursor = pcall(require, "smoothcursor")
if not status_ok then
  return
end

smooth_cursor.setup {
  autostart = true,
  cursor = "", -- cursor shape (need nerd font)
  intervals = 35, -- tick interval
  linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
  type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
  fancy = {
    enable = false, -- enable fancy mode
    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
    body = {
      { cursor = "", texthl = "SmoothCursorRed" },
      { cursor = "", texthl = "SmoothCursorOrange" },
      { cursor = "●", texthl = "SmoothCursorYellow" },
      { cursor = "●", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" },
  },
  priority = 100, -- set marker priority
  speed = 25, -- max is 100 to stick to your current position
  texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
  threshold = 3,
  timeout = 3000,
}
