local indent_blankline = require("indent_blankline")
local neogit = require("neogit")
local aerial = require("aerial")

-- keymaps to remember:
-- comment current line: gcc
-- linewise comment visual selection -> gc
-- blockwise comment visual seleciton -> gb

aerial.setup({
	on_attach = function(_bufnr)
		-- currently using `(` and `)` to navigate errors
		-- vim.keymap.set("n", "(", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		-- vim.keymap.set("n", ")", "<cmd>AerialNext<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
	end,
})

neogit.setup({
	integrations = {
		diffview = true,
	},
})
vim.keymap.set("n", "<leader>g", neogit.open)

indent_blankline.setup({
	buftype_exclude = { "terminal" },
	filetype_exclude = { "startify", "help", "dashboard", "Outline" },
	indent_blankline_use_treesitter = true,
	indent_blankline_show_current_context = true,
})
