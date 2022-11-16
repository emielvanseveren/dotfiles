local neoclip = require("neoclip")
local hop = require("hop")
local harpoon = require("harpoon")
local gitsigns = require("gitsigns")
local indent_blankline = require("indent_blankline")
local bufferline = require("bufferline")
local colorizer = require("colorizer")
local neogit = require("neogit")
local fidget = require("fidget")

colorizer.setup()
neoclip.setup()
hop.setup()
fidget.setup({})

harpoon.setup({
	nav_first_in_list = true,
})

neogit.setup({
	integrations = {
		diffview = true,
	},
})

gitsigns.setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},

	signcolumn = true, -- show signs in column
	numhl = false, -- highlight line number
	linehl = false, -- line highlighting
	word_diff = false, -- highlight word diffs
	attach_to_untracked = true, -- attach to untracked files

	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
})

indent_blankline.setup({
	buftype_exclude = { "terminal" },
	filetype_exclude = { "startify", "help", "dashboard", "Outline" },
	indent_blankline_use_treesitter = true,
	indent_blankline_show_current_context = true,
})

bufferline.setup({
	options = {
		mode = "buffers",
		separator_style = "slant", -- Space between tabs
		enforce_regular_tabs = true, -- Allow to extend tab size when name is longer than tab_size
		show_buffer_default_icon = true, -- Show file icon
		show_buffer_close_icons = false, -- Show close icon
		always_show_bufferline = true, -- Only show bufferline when more than 1 tab
		diagnostics = "nvim_lsp", -- Change color of filename when file has an error
		diagnostics_update_in_insert = false,
		numbers = "none", -- Don't show numbers on tab
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		offsets = { { filetype = "NvimTree", text = "File explorer", text_align = "left" } },
		show_buffer_icons = true,
	},
})
