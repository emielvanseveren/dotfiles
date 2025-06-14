local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local severity = vim.diagnostic.severity


local group = augroup("diagnostics", { clear = true })

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },

  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = " ",
      [severity.INFO] = " ",
    }
  }
})

autocmd("ModeChanged", {
  group = group,
  pattern = { "n:i", "v:s" },
  desc = "Disable diagnostics in insert and select mode",
  callback = function(e) vim.diagnostic.enable(false, { bufnr = e.buf }) end
})

autocmd("ModeChanged", {
  group = group,
  pattern = "i:n",
  desc = "Enable diagnostics in normal mode",
  callback = function(e) vim.diagnostic.enable(true, { bufnr = e.buf }) end
})
