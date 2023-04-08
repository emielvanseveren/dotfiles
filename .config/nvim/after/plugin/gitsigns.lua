local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- show signs in column
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  linehl = false,
  numhl = false, -- highlight line number
  word_diff = false, -- highlight word diffs
  attach_to_untracked = true,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
})

vim.keymap.set("n", "gj", gitsigns.next_hunk, { desc = "Next git hunk" })
vim.keymap.set("n", "gk", gitsigns.prev_hunk, { desc = "Previous git hunk" })
vim.keymap.set("n", "gl", gitsigns.blame_line, { desc = "View git blame" })
vim.keymap.set("n", "gp", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
