return {
  "stevearc/conform.nvim",
  event = { "BufReadPre"},
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" } })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
    },
    format_after_save = {
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      terraform = { "terraform_fmt" },
      rust = { "rustfmt" },

    },
  },
}
