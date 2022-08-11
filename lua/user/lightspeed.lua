local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
  return
end

lightspeed.setup {
  ignore_case = true,
  exit_after_idle_msecs = { unlabeled = 2000, labeled = nil },
  --- s/x ---
  jump_to_unique_chars = { safety_timeout = 400 },
}
