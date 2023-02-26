local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  diagnostics = {
    enable = true,
  },
  update_cwd = true,
  view = {
    adaptive_size = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer treeview." })
