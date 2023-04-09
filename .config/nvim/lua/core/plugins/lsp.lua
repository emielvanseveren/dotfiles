-- These are the language servers installed and managed by mason
local lsp_servers = {
  "tsserver",
  "yamlls",
  "pyright",
  "eslint",
  "jsonls",
  "texlab",
  "ltex",
  "rust_analyzer",
  "lua_ls",
  "clangd",
  "cmake",
  "gopls",
}

-- Some tools can be installed with mason, but are not language servers.
local other = {
  "stylua",
  "luacheck",
}

-- Add the lsp servers to other, so they can all be installed automatically by mason.
for k, v in pairs(lsp_servers) do
  other[k] = v
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach_wrapper = require("core.utils").on_attach

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts) -- Go to next/previous error.
      vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader><Space>", vim.diagnostic.open_float, opts) -- Open a floating error/warning window.

      local on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = true
        client.server_capabilities.document_range_formatting = false

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go the symbols declaration.
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to the symbols defintion.
        vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts) -- Go to the symbols type definition.
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- List all the references to the symbol under the cursor in the quickfix window.

        -- Note, whel done twice it will enter the window, can't close with escape, gotta use q.
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Displays information about the symbol under the cursor.
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts) -- Displays the signature of the function under the cursor.
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- List of actions that can be taken on the current file.
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename the symbol under the cursor (project wide).
      end
      --------------------------------------------------------------------------------
      -- Default LSP servers
      -- Use a loop to conveniently call 'setup' on multiple language servers and
      -- map buffer local keybindings when the language server attaches.
      --------------------------------------------------------------------------------
      for _, lsp in pairs(lsp_servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach_wrapper(on_attach),
          capabilities = capabilities,
        })
      end

      --------------------------------------------------------------------
      -- Custom LSP configuration
      --------------------------------------------------------------------
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach_wrapper(on_attach),
        capabilities = capabilities,
        -- Use rustup to find the correct rust-analyzer binary
        cmd = {
          "rustup",
          "run",
          "stable",
          "rust-analyzer",
        },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              allFeatures = true,
              overrideCommand = {
                "cargo",
                "clippy",
                "--workspace",
                "--message-format=json",
                "--all-targets",
                "--all-features",
              },
            },
          },
        },
      })

      -- required to manually install the lua-language-server
      lspconfig.lua_ls.setup({
        on_attach = on_attach_wrapper(on_attach),
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = { enable = false },
          },
        },
      })

      -- https://dev.languagetool.org/finding-errors-using-n-gram-data.html
      lspconfig.ltex.setup({
        on_attach = on_attach_wrapper(on_attach),
        capabilities = capabilities,
        settings = {
          ltex = {
            additionalRules = {
              languageModel = "~/.ngrams/",
            },
          },
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = other,
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = other,
      automatic_installation = true,
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local b = require("null-ls").builtins

      local sources = {
        b.diagnostics.eslint_d,
        b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),
        b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

        -- code actions
        b.code_actions.eslint_d,
        b.code_actions.gitsigns,

        -- formatting
        b.formatting.eslint_d,
        b.formatting.prettierd.with({
          filetypes = {
            "html",
            "json",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "yaml",
            "scss",
            "css",
            "markdown",
          },
        }),
        b.formatting.stylua,
        b.formatting.shfmt,
        b.formatting.terraform_fmt,
        b.formatting.rustfmt,
      }

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        debug = true,
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ buffer = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
