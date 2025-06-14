return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  keys = {
    { "<leader><leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Move cursor in tree to [f]ile of current buffer." },
    { "<leader><leader>t", "<cmd>NvimTreeToggle<CR>",   desc = "[t]oggle file explorer treeview." },
  },
  opts = {
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
      dotfiles = false,
      custom = { '^.git$' }
    },
    update_focused_file = {
      enable = true,
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          git = true,
        },
      },
    },
  },
}
