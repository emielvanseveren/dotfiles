-- ===============================================================
-- # General Autocommands
-- Basically callbacks that are executed when a certain event is triggered.
-- ===============================================================

-- Automatically source and re-compile packer whenever you save this init.lua
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   command = 'source <afile> | PackerCompile',
--   group = vim.api.nvim_create_augroup('Packer', { clear = true }),
--   pattern = { vim.fn.expand '$MYVIMRC', '*/lua/**' },
-- })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

-- [[ Packadd cfilter on qf ]]
vim.api.nvim_create_autocmd("filetype", {
	callback = function()
		vim.cmd([[packadd cfilter]])
	end,
	group = vim.api.nvim_create_augroup("quickfixlist", { clear = true }),
	pattern = "qf",
})
