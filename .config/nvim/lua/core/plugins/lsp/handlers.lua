local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn", text = " " },
    { name = "DiagnosticSignHint", text = " " },
    { name = "DiagnosticSignInfo", text = " " },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = "",
    })
  end

  vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    severity = {
      min = vim.diagnostic.severity.WARN
    },
    virtual_text = {
      spacing = 5,
    },
    update_in_insert = true,
  })

  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev,
    { noremap = true, silent = true, desc = "Go to nexst diagnostic" })
  vim.keymap.set("n", "<leader>dN", vim.diagnostic.goto_next,
    { noremap = true, silent = true, desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "<leader><Space>", vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = "Open diagnostic float" })

  -- format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
      vim.lsp.buf.format()
    end,
  })


  vim.cmd([[autocmd FileType * set formatoptions-=ro]])
end

return M
