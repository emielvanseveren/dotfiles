return function()
  require("neodev").setup()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local mason = require("mason")

  local lsp_conf = require("core.plugins.lsp.settings")

  local servers = {
    prismals = {},
    dockerls = {},
    pyright = {},
    clangd = {},
    texlab = {},
    ltex = lsp_conf.latex,
    gopls = lsp_conf.go,
    lua_ls = lsp_conf.lua,
    yamlls = lsp_conf.yaml,
    tsserver = lsp_conf.ts,
    rust_analyzer = lsp_conf.rust,
    html = { filetypes = { "html", "hbs" } },
    terraformls = { filetypes = { "terraform", "tf" } },
  }



  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = lsp_conf.on_attach,
        capabilities = lsp_conf.capabilities,
        cmd = (servers[server_name] or {}).cmd,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      })
    end,
  })

  require("illuminate").configure({
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  })

  require("core.plugins.lsp.handlers").setup()
end
