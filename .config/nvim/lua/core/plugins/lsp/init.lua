return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "folke/lazydev.nvim",
      "b0o/schemastore.nvim"
    },
    opts = {
      inlay_hints = {
        enabled = false
      },
      diagnostics = {
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },

        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true
        },
        -- Not all LSP servers support codelens, some lsp servers have it disabled by default.
        codelens = {
          enabled = true
        },
        -- only show errors and warnings in virtual text
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "",
        },
      },
    },
    config = require("core.plugins.lsp.config"),
  },
}



