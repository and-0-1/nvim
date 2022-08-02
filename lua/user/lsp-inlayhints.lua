local status_ok, hints = pcall(require, "lsp-inlayhints")
if not status_ok then
  return
end

vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

local group = vim.api.nvim_create_augroup("LspAttach_inlayhints", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- vim.notify(client)
    require("lsp-inlayhints").on_attach(args.buf, client)
  end,
})

hints.setup {}
