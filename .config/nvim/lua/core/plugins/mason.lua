-- Non-LSP tooling, as mason package names (which are not always the binary
-- name). LSP servers live in lsp/servers.lua and are installed by
-- mason-lspconfig, which translates lspconfig names for us.
--
-- tofu_fmt and rustfmt are absent on purpose: they are not mason packages, they
-- come from /usr/bin/tofu and rustup respectively.
local tools = {
  "black",
  "codelldb",
  "eslint_d",
  "isort",
  "prettierd",
  "shellcheck",
  "shfmt",
  "stylua",
}

return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUpdate",
      "MasonLog",
    },
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)

      -- mason 2.x dropped `ensure_installed` from setup(), so drive the
      -- registry directly. Silently doing nothing is the failure mode here,
      -- so keep this list short and check :Mason if a tool goes missing.
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in ipairs(tools) do
          if registry.has_package(name) then
            local pkg = registry.get_package(name)
            if not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end)
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = true,
    opts = {
      ensure_installed = vim.tbl_keys(require("core.plugins.lsp.servers")),
      -- lsp/config.lua enables servers explicitly, so installing a server
      -- ad hoc with :MasonInstall does not silently start attaching it.
      automatic_enable = false,
    },
  },
}
