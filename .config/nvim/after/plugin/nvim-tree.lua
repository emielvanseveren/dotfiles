local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  diagnostics = {
    enable = true,
  },
  update_cwd = true,
  view = {
    adaptive_size = true,
  },
  git = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
})

vim.keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer treeview." })
vim.keymap.set("n", "<leader><leader>f", "<cmd>NvimTreeFindFile<CR>", { desc = "Move cursor in tree to file of current buffer." })
