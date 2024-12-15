return function()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  local lsp_conf = require("core.plugins.lsp.settings")

  local servers = {
    prismals = {},
    dockerls = {},
    pyright = {},
    clangd = {},
    texlab = {},
    slint_lsp = {},
    ltex = lsp_conf.latex,
    gopls = lsp_conf.go,
    lua_ls = lsp_conf.lua,
    yamlls = lsp_conf.yaml,
    ts_ls = lsp_conf.ts,
    rust_analyzer = lsp_conf.rust,
    html = { filetypes = { "html", "hbs" } },
    jsonls = lsp_conf.json,
    terraformls = { filetypes = { "terraform", "tf" } },
    bashls = {}
  }



  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      -- https://github.com/neovim/nvim-lspconfig/pull/3232
      if server_name == "tsserver" then
        server_name = 'ts_ls'
      end

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
