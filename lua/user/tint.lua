local status_ok, tint = pcall(require, "tint")
if not status_ok then
  return
end

tint.setup {}
