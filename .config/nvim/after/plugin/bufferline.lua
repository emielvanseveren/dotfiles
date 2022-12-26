local bufferline = require("bufferline")

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
