local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end

-- Disable inline diagnostic text messages
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts) -- Go to next/previous error.
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>le", "<cmd>Telescope diagnostics<CR>", opts) -- Open a list of all errors/warnings.
vim.keymap.set("n", "<leader><Space>", vim.diagnostic.open_float, opts) -- Open a floating error/warning window.

local on_attach = function(cl, bufnr) -- _=client
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	cl.server_capabilities.document_formatting = true
	cl.server_capabilities.document_range_formatting = false

	-- To go back to your original position, you can use <c-t> it uses a separate tag stack instead of the jump stack.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go the symbols declaration.
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to the symbols defintion.
	vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts) -- Go to the symbols type definition.
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- List all the references to the symbol under the cursor in the quickfix window.
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Displays information about the symbol under the cursor.
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts) -- Displays the signature of the function under the cursor.
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename the symbol under the cursor (project wide).
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- List of actions that can be taken on the current file.

	-- `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format({
				filter = function(client)
					-- apply whatever logic you want
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("formatOnSave", { clear = true }),
		callback = function()
			vim.api.nvim_command("Format")
		end,
	})

	vim.keymap.set("n", "gq", "<cmd>Format<CR>")
end

--------------------------------------------------------------------------------
-- Default LSP servers
-- Use a loop to conveniently call 'setup' on multiple language servers and
-- map buffer local keybindings when the language server attaches.
--------------------------------------------------------------------------------
local servers = { "pyright", "yamlls", "eslint", "jsonls", "tsserver", "texlab" }
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

--------------------------------------------------------------------------------
-- Custom LSP configuration
--------------------------------------------------------------------

-- required to manually install the lua-language-server
lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = { enable = false },
		},
	},
})

--------------------------------------------------------------------
-- Rust
-- Rust tools sets up the lsp server automatically.
--------------------------------------------------------------------
require("rust-tools").setup({
	tools = {
		executor = require("rust-tools/executors").termopen, -- How to execute terminal commands
		runnables = { use_telescope = true }, -- Wether to use telescope for selection menu or not

		-- apply to the defualt RustSetInlayHints
		inlay_hints = {
			auto = true, -- Automatically set inlay hints
			only_current_line = false, -- Only show inlay hints for the current line
			show_parameter_hints = true, -- Wether to show parameter hints with the inlay hints or not
			show_variable_name = true, -- Wether to show variable name before type hints with the inlay hints or not
			max_len_align = true, -- Wether to align to the length of the longest line in the file
			highlight = "Comment", -- The color of the hints
		},

		hover_actions = {
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
		},
	},

	-- Lsp server configuration
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		standalone = true,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
			},
		},
	},
})
