local present, nvimtree = pcall(require, "nvim-tree")

if not present then
	return
end

vim.keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer treeview." })

nvimtree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
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
