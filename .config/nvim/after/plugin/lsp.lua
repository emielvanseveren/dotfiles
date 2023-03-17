local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

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

-- keep order mason, mason_lsp_config
require("mason").setup({
  ensure_installed = other,
  automatic_installation = true,
})

-- This installs the actual language servers
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
})

-- Disable inline diagnostic text messages
vim.diagnostic.config({
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
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts) -- Go to next/previous error.
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader><Space>", vim.diagnostic.open_float, opts) -- Open a floating error/warning window.

local on_attach = function(cl, bufnr) -- _=client
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  cl.server_capabilities.document_formatting = true
  cl.server_capabilities.document_range_formatting = false

  -- To go back to your original position, you can use <c-t> it uses a separate tag stack instead of the jump stack.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go the symbols declaration.
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to the symbols defintion.
  vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts) -- Go to the symbols type definition.
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- List all the references to the symbol under the cursor in the quickfix window.
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Displays information about the symbol under the cursor.
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, bufopts) -- Displays the signature of the function under the cursor.
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
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

--------------------------------------------------------------------
-- Custom LSP configuration
--------------------------------------------------------------------
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
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
  on_attach = on_attach,
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
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ltex = {
      additionalRules = {
        languageModel = "~/.ngrams/",
      },
    },
  },
})
