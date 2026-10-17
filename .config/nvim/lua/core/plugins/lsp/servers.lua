-- Single source of truth for LSP servers.
-- Keys are lspconfig server names; mason-lspconfig translates them to mason
-- package names, and lsp/config.lua feeds each value to vim.lsp.config().
--
-- Values are vim.lsp.Config tables: top-level keys (filetypes, cmd, root_markers)
-- sit at the top, and server settings go under `settings`.
local cfg = require("core.plugins.lsp.configs")

return {
  bashls = {},
  clangd = {},
  dockerls = {},
  pyright = {},
  slint_lsp = {},
  texlab = {},

  gopls = { settings = cfg.go },
  jsonls = { settings = cfg.json },
  ltex = { settings = cfg.latex },
  lua_ls = { settings = cfg.lua },
  rust_analyzer = { settings = cfg.rust },
  ts_ls = { settings = cfg.typescript },
  yamlls = { settings = cfg.yaml },

  html = { filetypes = { "html", "handlebars" } },
  tinymist = { filetypes = { "typst" } },
  tofu_ls = { filetypes = { "terraform", "terraform-vars" } },
}
