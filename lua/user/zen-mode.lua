local zen_ok, zen = pcall(require, "zen-mode")

if not zen_ok then
  vim.notify "Zen mode not installed"
  return
end

zen.setup {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "yes", -- disable signcolumn
      number = true, -- disable number column
      relativenumber = true, -- disable relative numbers
      cursorline = true, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = true, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = true, -- disables the ruler text in the cmd line area
      showcmd = true, -- disables the command in the last line of the screen
    },
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
  },
}

require("user.keymaps.bind").nnoremap("<leader>z", function()
  zen.toggle()
end)
