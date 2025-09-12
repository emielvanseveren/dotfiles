return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  dependencies = { "mason.nvim" },
  lazy = true,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ formatters = { "injected" } })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = {
    format = {
      timeout_ms = 500,
      async = false,
      quiet = false,
    },
    format_on_save = {
      lsp_format = "fallback"
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "isort", "black", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      terraform = { "tofu_fmt" },
    },
  },
}
