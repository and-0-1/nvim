local ok, no_neck_pain = pcall(require, "no-neck-pain")
if not ok then
  vim.notify "no-neck-pain load issue"
  return
end
-- values below are the default
no_neck_pain.setup {
  -- the width of the focused buffer when enabling NNP.
  -- If the available window size is less than `width`, the buffer will take the whole screen.
  width = 133,
  -- prints useful logs about what event are triggered, and reasons actions are executed.
  debug = false,
  -- options related to the side buffers
  buffers = {
    -- if set to `false`, the `left` padding buffer won't be created.
    left = true,
    -- if set to `false`, the `right` padding buffer won't be created.
    right = true,
    -- if set to `true`, the side buffers will be named `no-neck-pain-left` and `no-neck-pain-right` respectively.
    showName = false,
    -- the buffer options when creating the buffer
    options = {
      bo = {
        filetype = "no-neck-pain",
        buftype = "nofile",
        bufhidden = "hide",
        modifiable = false,
        buflisted = false,
        swapfile = false,
      },
      wo = {
        cursorline = false,
        cursorcolumn = false,
        number = false,
        relativenumber = false,
        foldenable = false,
        list = false,
      },
    },
  },
}

-- NOTE: autocomand for activating on init
vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = "OnVimEnter",
  pattern = "*",
  callback = function()
    vim.schedule(function()
      require("no-neck-pain").enable()
    end)
  end,
})
