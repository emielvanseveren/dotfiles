-- ===============================================================
-- # General Autocommands
-- Basically callbacks that are executed when a certain event is triggered.
-- ===============================================================

local function augroup(name)
  return vim.api.nvim_create_augroup("lit_" .. name, { clear = true })
end

-- Created once, at module level. Creating these inside the LspAttach callback
-- would clear=true on every attach and so wipe the buffer-local autocmds
-- registered for every previously attached buffer.
local lsp_format_group = augroup("lsp_format")
local lsp_highlight_group = augroup("lsp_document_highlight")

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  desc = "Check if file changed on focus gain or terminal close",
  command = "checktime",
})

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("YankHighlight"),
  desc = "Highlight text on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  desc = "Go to last loc when opening a buffer",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  desc = "Close certain filetypes with <q>",
  pattern = {
    "help",
    "man",
    "lspinfo",
    "qf",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  desc = "Enable wrap and spell for markdown and git commit files",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  desc = "Auto create directory for file, if it does not exist",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})


-- Make comments more prominent -- they are important. Runs on ColorScheme so it
-- is applied on top of whatever theme is active, including after switching.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("comment_color"),
  desc = "Bright orange comments, regardless of theme",
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#FFA500", bg = "#3D2B0E", italic = true })
    -- Treesitter and LSP semantic tokens have their own groups; not every theme
    -- links them to Comment, so make sure they follow it.
    for _, group in ipairs({ "@comment", "@comment.documentation", "@lsp.type.comment" }) do
      vim.api.nvim_set_hl(0, group, { link = "Comment" })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable comment leader when going inserting new line when in comment",
  group = augroup("comment"),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove("ro")
  end
})

-- Add keymaps when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp"),
  desc = "Lsp attach",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if not client then
      return
    end

    local bufnr = args.buf

    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = false

    -- grt and grx are new 0.12 defaults (type_definition, codelens.run); gtd and
    -- <leader>ca below cover the same ground.
    for _, bind in ipairs({ "grn", "gra", "gri", "grr", "gri", "grt", "grx", "gO" }) do
      pcall(vim.keymap.del, "n", bind)
    end

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)      -- Go the symbols declaration.
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)       -- Go to the symbols definition.
    vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts) -- Go to the symbols type definition.
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)       -- List all the references to the symbol under the cursor in the quickfix window.

    -- Note, on <KK> it will enter the signature window, use <q> to close it.
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)                  -- Displays information about the symbol under the cursor.
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts) -- Displays the signature of the function under the cursor.
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)   -- List of actions that can be taken on the current file.
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)        -- Rename the symbol under the cursor (project wide).

    -- Highlight the other references to the symbol under the cursor.
    if client:supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = lsp_highlight_group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = lsp_highlight_group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Code lenses. 0.12 renders these as virtual lines, and enable() does its own
    -- debounced refresh, so this needs no autocmd of its own.
    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end

    -- format on save
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format_group,
        buffer = bufnr,
        callback = function()
          require("conform").format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
