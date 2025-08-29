local left = "%0.50f"
local right = "%h%w%m%r%=%-14.(%l,%c%V%) %P"
local M = {
  left = left,
  right = right,
  full = left .. " " .. right,
}

return M
