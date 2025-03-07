return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/lazydev.nvim",
      "RRethy/vim-illuminate",
      "b0o/schemastore.nvim"
    },
    opts = {
      inlay_hints = {
        enabled = false
      },
      -- @type vim.diagnostic.Opts
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
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = { "stylua", "luacheck", "shellcheck", "eslint_d", "prettierd", "terraform_fmt", "rustfmt", "black", "isort", "bashls", "tsserver" },
      automatic_installation = true,
    },
  },
}
