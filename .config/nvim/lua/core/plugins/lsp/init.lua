return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "RRethy/vim-illuminate",
    },
    opts = {
      inlay_hints = {
        enabled = true
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
        -- only show underline for info diagnostics
        underline = {
          severity = { max = vim.diagnostic.severity.INFO },
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
      ensure_installed = { "stylua", "luacheck", "shellcheck", "eslint_d", "prettierd", "terraform_fmt", "rustfmt", "black", "isort" },
      automatic_installation = true,
    },
  },
}
