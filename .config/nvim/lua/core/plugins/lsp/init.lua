return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "RRethy/vim-illuminate",
    },
    opts = {
      diagnostics = {
        signs = true,
        update_in_insert = false,
        severity_sort = false,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        -- only show underline for hints
        underline = {
          severity = { max = vim.diagnostic.severity.INFO },
        },
        -- only show errors and warnings in virtual text
        virtual_text = {
          severity = { min = vim.diagnostic.severity.ERROR },
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
