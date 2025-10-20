return function()
  local lsp_server_configs = require("core.plugins.lsp.configs")

  -- Ensure that the keys match LSP servers listed in mason.nvim
  local servers = {
    dockerls = {},
    pyright = {},
    clangd = {},
    texlab = {},
    slint_lsp = {},
    ltex = lsp_server_configs.latex,
    gopls = lsp_server_configs.go,
    lua_ls = lsp_server_configs.lua,
    yamlls = lsp_server_configs.yaml,
    ts_ls = lsp_server_configs.typescript,
    rust_analyzer = lsp_server_configs.rust,
    html = { filetypes = { "html", "hbs" } },
    jsonls = lsp_server_configs.json,
    terraformls = { filetypes = { "terraform", "tf" } },
    bashls = {},
  }


  -- custom capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.semanticTokens.multilineTokenSupport = true


  for server_name, server_settings in pairs(servers) do
    vim.lsp.enable(server_name, true)
    vim.lsp.config(server_name, {
      capabilities = capabilities,
      settings = server_settings
    })
  end





  -- custom LSP handlers
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
    update_in_insert = false,
  })
end
