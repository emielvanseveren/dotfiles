return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUpdate",
    "MasonLog",
  },
  opts = {
    -- Mason manages all LSP servers, linters and formatters.
    -- The LSP servers are listed in lsp/config.lua
    -- Linters and formatters are listed here.
    ensure_installed = {
      -- LSP servers
      "dockerls",
      "pyright",
      "clangd",
      "texlab",
      "slint_lsp",
      "ltex",
      "gopls",
      "lua_ls",
      "yamlls",
      "ts_ls",
      "rust_analyzer",
      "html",
      "jsonls",
      "terraformls",
      "bashls",
      -- Linters and formatters
      "stylua",
      "luacheck",
      "shellcheck",
      "eslint_d",
      "prettierd",
      "tofu_fmt",
      "rustfmt",
      "black",
      "isort",
    },
    automatic_installation = true,
  },
}
