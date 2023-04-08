local M = {}

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end,
  })
end

return M
