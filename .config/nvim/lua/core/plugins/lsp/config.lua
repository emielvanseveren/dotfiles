return function()
  local servers = require("core.plugins.lsp.servers")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.semanticTokens.multilineTokenSupport = true

  -- '*' is the base every server config inherits from.
  vim.lsp.config("*", { capabilities = capabilities })

  for name, config in pairs(servers) do
    if not vim.tbl_isempty(config) then
      vim.lsp.config(name, config)
    end
    vim.lsp.enable(name)
  end
end
