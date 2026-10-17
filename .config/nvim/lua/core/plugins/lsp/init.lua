return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "folke/lazydev.nvim",
      "b0o/schemastore.nvim",
    },
    config = require("core.plugins.lsp.config"),
  },
}
