local present1, nvimtree = pcall(require, "nvim-tree")
local present2, nvimtreecontext = pcall(require, "treesitter-context")

if not (present1 and present2) then
  return
end

nvimtreecontext.setup()

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  view = {
    adaptive_size = true,
    width = 25,
    hide_root_folder = true,
  },
  actions = {
    open_file = {
      resize_window = true
    }
  }
})
