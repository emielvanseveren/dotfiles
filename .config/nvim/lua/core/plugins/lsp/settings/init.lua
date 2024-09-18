local M = {}

M.ts = require("core.plugins.lsp.settings.ts")
M.go = require("core.plugins.lsp.settings.go")
M.lua = require("core.plugins.lsp.settings.lua")
M.yaml = require("core.plugins.lsp.settings.yaml")
M.rust = require("core.plugins.lsp.settings.rust")
M.latex = require("core.plugins.lsp.settings.latex")
M.json = require("core.plugins.lsp.settings.json")

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())


M.on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = true
  client.server_capabilities.document_range_formatting = false

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)      -- Go the symbols declaration.
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)       -- Go to the symbols definition.
  vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts) -- Go to the symbols type definition.
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)       -- List all the references to the symbol under the cursor in the quickfix window.

  -- Note, whel done twice it will enter the window, can't close with escape, gotta use q.
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)                  -- Displays information about the symbol under the cursor.
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts) -- Displays the signature of the function under the cursor.
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)   -- List of actions that can be taken on the current file.
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)        -- Rename the symbol under the cursor (project wide).

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = true
  end

  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  require("illuminate").on_attach(client)
end

return M
