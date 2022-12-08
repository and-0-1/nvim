local status_ok, windows = pcall(require, "windows")
if not status_ok then
  return
end

windows.setup {
  autowidth = { --		     |windows.autowidth|
    enable = true,
    winwidth = 5, --		      |windows.winwidth|
    filetype = { --	    |windows.autowidth.filetype|
      help = 2,
    },
  },
  ignore = { --			|windows.ignore|
    buftype = { "quickfix", "toggleterm", "term://*" },
    filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "toggleterm", "term://*" },
  },
  animation = {
    enable = false,
    duration = 300,
    fps = 60,
    easing = "in_out_sine",
  },
}
