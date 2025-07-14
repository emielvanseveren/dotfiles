-- ===============================================================
-- # General Autocommands
-- Basically callbacks that are executed when a certain event is triggered.
-- ===============================================================

local function augroup(name)
  return vim.api.nvim_create_augroup("lit_" .. name, { clear = true })
end

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
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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

    for _, bind in ipairs({ "grn", "gra", "gri", "grr", "gri", "gO" }) do
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

    -- format on save
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup("lsp_format"),
        callback = function()
          require("conform").format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          -- vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
