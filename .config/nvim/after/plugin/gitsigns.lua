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
  numhl = true, -- highlight line number
  linehl = false, -- line highlighting
  word_diff = false, -- highlight word diffs
  attach_to_untracked = true, -- attach to untracked files
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
})

vim.keymap.set("n", "gj", gitsigns.next_hunk, { desc = "Next git hunk" })
vim.keymap.set("n", "gk", gitsigns.prev_hunk, { desc = "Previous git hunk" })
vim.keymap.set("n", "gl", gitsigns.blame_line, { desc = "View git blame" })
vim.keymap.set("n", "gp", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
