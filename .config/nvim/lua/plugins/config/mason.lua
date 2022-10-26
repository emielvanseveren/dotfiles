-- keep order mason, mason_lsp_config
require("mason").setup()

-- This installs the actual language servers
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "tsserver", "yamlls", "pyright", "eslint", "jsonls" }
})
