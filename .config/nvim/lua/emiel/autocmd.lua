-- ===============================================================
-- # General Autocommands
-- Basically callbacks that are executed when a certain event is triggered.
-- ===============================================================

local function augroup(name)
  return vim.api.nvim_create_augroup("lit_" .. name, { clear = true })
end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup("YankHighlight"),
  pattern = "*",
})

-- [[ Packadd cfilter on qf ]]
vim.api.nvim_create_autocmd("filetype", {
  callback = function()
    vim.cmd([[packadd cfilter]])
  end,
  group = augroup("quickfixlist"),
  pattern = "qf",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
