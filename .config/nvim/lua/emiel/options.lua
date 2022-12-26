local opt = vim.opt
local g = vim.g
local api = vim.api

g.mapleader = "," -- Sets leader key to 'COMMA'

opt.shell = "/usr/bin/zsh" -- Sets default shell to zsh
opt.compatible = false -- don't try to be like vi.
opt.completeopt = "menuone,noinsert,noselect"
opt.cmdheight = 1 -- Height of command line
opt.updatetime = 750 -- milliseconds nothing is typed the swap file will be written to disk
opt.termguicolors = true -- Enable termguicolors
opt.background = "dark" -- Try to use dark colors
opt.clipboard = "unnamedplus" -- copy to system clipboard on yank
opt.relativenumber = true -- Show the line number relative to the line with the cursor
opt.linebreak = true -- Break lines when max is reached
opt.mouse = "a" -- Enable the mouse in all modes
opt.scrolloff = 5 -- Keep 5 lines below and above the cursor
opt.joinspaces = false -- Combine >1 consecutive spaces
opt.wrap = false -- No line wrapping
opt.conceallevel = 0
opt.autochdir = true -- Vim will change the current working dir whenever you open a file / switch buffers
opt.ruler = true -- Show the line and column number of the curser position
opt.tabstop = 2 -- Number of spaces that a <TAB> in the file counts for
opt.shiftwidth = 2 -- Tab shift
opt.softtabstop = 2 -- 2 space tab
opt.expandtab = true -- Use spaces for tabs
opt.ignorecase = true -- ignore case when searching

-- ===============================================================
-- # Gui Settings
-- ===============================================================
opt.backspace = "2" -- Backspace over newlines
opt.foldenable = false -- Disable folding by default
opt.number = true -- show line numbers
opt.cursorline = true -- highlight current line

-- Show those damn hidden characters
opt.listchars = "nbsp:¬,eol:¶,extends:»,precedes:«,trail:•,tab:»·"
opt.laststatus = 3 -- global statusline

-- ===============================================================
-- # Language specific configuration.
-- ===============================================================
api.nvim_command("au FileType make set noexpandtab shiftwidth=8 softtabstop=0") -- Makefiles must use tabs
api.nvim_command("au FileType yaml setl sw=2 sts=2")

-- ===============================================================
-- # Built-in debugger
-- ===============================================================
vim.cmd("packadd termdebug") -- Add termdebug
g.termdebugger = "rust-gdb" -- Set debugger to rust-gdb
g.termdebug_wide = 1 -- Set debugger to use wide terminal

-- ===============================================================
-- # Plugin configuration
-- ===============================================================

-- Github copilot
g.completion_enable_auto_popup = 1 -- Auto popup
g.completion_matching_ingore_case = 1 -- While in popup ignore caps.
g.copilot_no_tab_map = 1 -- Don't use <Tab> but <C-J> to accept the suggestion.
api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Vimtex (\ll to start compilation)
g.tex_flavor = "latex"
g.vimtex_view_method = "zathura" -- Use zathura to view compiled pdfs
g.vimtex_compiler_method = "latexmk"
g.vimtex_complete_close_braces = 1
g.vimtex_compiler_latexmk = {
	options = {
		"-pdf",
		"-shell-escape",
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}

-- Beacon
g.beacon_minimal_jump = 5 -- Only show beacon if the cursor jumps more than 5 lines.
g.beacon_size = 40 -- Size of the beacon
