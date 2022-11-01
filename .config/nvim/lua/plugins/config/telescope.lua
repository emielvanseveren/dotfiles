local present, telescope = pcall(require, "telescope")

local actions = require("telescope.actions")

if not present then
	return
end

local options = {
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		file_ignore_patterns = { "node_modules" },
		path_display = { "truncate" },
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			n = { -- normal mode
				-- Follows same flow as search result hopping
				["<C-n>"] = actions.move_selection_worse,
				["<C-p>"] = actions.move_selection_better,
				["<Esc>"] = actions.close,
			},
			i = { -- insertion mode
				["<C-n>"] = actions.move_selection_worse,
				["<C-p>"] = actions.move_selection_better,
				["<Esc>"] = actions.close,
			},
		},
	},
	extensions_list = { "emoji", "terms", "ui-select", "neoclip", "harpoon" },
}

telescope.setup(options)

-- load extensions
pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		telescope.load_extension(ext)
	end
end)
