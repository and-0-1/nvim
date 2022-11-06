local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  "                     ______                       ",
  "                    /     /\\                     ",
  "                   /     /##\\                    ",
  "                  /     /####\\                   ",
  "                 /     /######\\                  ",
  "                /     /########\\                 ",
  "               /     /##########\\                ",
  "              /     /#####/\\#####\\              ",
  "             /     /#####/++\\#####\\             ",
  "            /     /#####/++++\\#####\\            ",
  "           /     /#####/\\+++++\\#####\\          ",
  "          /     /#####/  \\+++++\\#####\\         ",
  "         /     /#####/    \\+++++\\#####\\        ",
  "        /     /#####/      \\+++++\\#####\\       ",
  "       /     /#####/        \\+++++\\#####\\      ",
  "      /     /#####/__________\\+++++\\#####\\     ",
  "     /                        \\+++++\\#####\\    ",
  "    /__________________________\\+++++\\####/     ",
  "    \\+++++++++++++++++++++++++++++++++\\##/      ",
  "     \\+++++++++++++++++++++++++++++++++\\/       ",
  "      ``````````````````````````````````          ",
}
dashboard.section.buttons.val = {
  dashboard.button(
    "f",
    icons.documents.Files .. " Find file",
    "<cmd>lua require('user.telescope.finders').project_files()<cr>"
  ),
  dashboard.button("t", icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
  -- dashboard.button("n", icons.ui.Note .. " Notebook", ":e ~/Notes/<cr>"),
  dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("u", icons.ui.CloudDownload .. " Update", ":PackerSync<CR>"),
  dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}
dashboard.section.footer.opts.hl = "Constant"
dashboard.section.header.opts.hl = "Macro"
dashboard.section.buttons.opts.hl = "Macro"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)

require "user.alpha.keymaps"
