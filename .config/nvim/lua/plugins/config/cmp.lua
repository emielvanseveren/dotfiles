local present1, cmp = pcall(require, "cmp")
local present2, lspkind = pcall(require, "lspkind")
local present3, luasnip = pcall(require, "luasnip")

if not (present1 and present2 and present3) then
	return
end

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local modes = { "i", "s", "c" }

local completionMappings = {
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), modes),
	["<C-e>"] = cmp.mapping(cmp.mapping.abort(), modes),
	-- C-j and C-k are bound to moving in insertion
	["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), modes),
	["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), modes),

	-- Intellij like mapping
	-- If no completion is selected, insert the first one in the list,
	-- If a completion is selected insert this one.
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			local entry = cmp.get_selected_entry()
			if not entry then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					cmp.confirm()
				end
			end
		else
			fallback()
		end
	end, modes),
}

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	window = {
		completion = {
			-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
			border = border("CmpBorder"),
		},
		documentation = { -- no border, native-style scrollbar
			border = nil,
			scrollbar = "",
		},
	},
	confirmation = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert(completionMappings),

	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
})

-- completion for commandline
cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
	},
	mapping = cmp.mapping.preset.insert(completionMappings),
})

-- completions for / based search on current buffer
cmp.setup.cmdline("/", {
	sources = {
		name = "buffer",
	},
})
