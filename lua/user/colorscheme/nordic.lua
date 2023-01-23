local status_ok, nordic = pcall(require, "nordic")
if not status_ok then
  return
end

nordic.load()
