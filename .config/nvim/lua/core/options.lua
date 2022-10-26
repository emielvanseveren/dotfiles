local opt = vim.opt
local g = vim.g
local api = vim.api

g.mapleader = "," -- Sets leader key to 'COMMA'
g.vim_version = vim.version().minor
g.auto_save = 1 -- Enable AutoSave on startup
g.show_spaces_that_precede_tabs = 1 -- Highlight spaces that appear before or in-between tabs

opt.shell          = "/usr/bin/zsh" -- Sets default shell to zsh
opt.compatible     = false -- don't try to be like vi.
opt.completeopt    = "menuone,noinsert,noselect"
opt.cmdheight      = 1 -- Height of command line
opt.updatetime     = 750 -- milliseconds nothing is typed the swap file will be written to disk
opt.termguicolors  = true -- Enable termguicolors
opt.background     = "dark" -- Try to use dark colors
opt.signcolumn     = "auto" -- Show signs in the right side of the line
opt.syntax         = "enable"
opt.autoindent     = true -- Copy indent from current line when starting a new line
opt.background     = "dark" -- Fallback
opt.clipboard      = "unnamedplus" -- copy to system clipboard on yank
opt.relativenumber = true -- Show the line number relative to the line with the cursor
opt.linebreak      = true -- Break lines when max is reached
opt.encoding       = "utf-8" -- Set encoding to utf-8
opt.mouse          = "a" -- Enable the mouse in all modes
opt.wildmenu       = true -- Much nicer tab completion for commands
opt.scrolloff      = 5 -- Keep 5 lines below and above the cursor
opt.autoread       = true -- Reload files changed outside vim
opt.hidden         = true -- hides buffers instead of closing them.
opt.joinspaces     = false -- Combine >1 consecutive spaces
opt.visualbell     = false -- No annoying unnecessary sounds
opt.swapfile       = false -- No swap files
opt.backup         = false -- No swap files
opt.wb             = false -- No swap files
opt.wrap           = false -- No line wrapping
opt.spelllang      = "en" -- Set spell language to English
opt.conceallevel   = 0
opt.autochdir      = false -- Vim will change the current working dir whenever you open a file / switch buffers
opt.ruler          = true -- Show the line and column number of the curser position
opt.tabstop        = 2 -- Number of spaces that a <TAB> in the file counts for
opt.shiftwidth     = 2 -- Tab shift
opt.softtabstop    = 2 -- 2 space tab
opt.expandtab      = true -- Use spaces for tabs
opt.smarttab       = true -- Insert tabstop number of spaces when the tab key is pressed
opt.ignorecase     = true -- ignore case when searching
opt.incsearch      = true -- search as characters are entered
opt.hlsearch       = true -- highlight all matches

-- ===============================================================
-- # Gui Settings
-- ===============================================================
opt.backspace    = "2" -- Backspace over newlines
opt.foldenable   = false -- Disable folding by default
opt.number       = true -- show line numbers
opt.showcmd      = true -- show command in bottom bar
opt.cursorcolumn = false
opt.cursorline   = true -- highlight current line
opt.lazyredraw   = true -- Don't update screen during macro and script execution.

-- Show those damn hidden characters
-- Verbose: vim.opt.listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
opt.listchars = "nbsp:¬,extends:»,precedes:«,trail:•"
opt.laststatus = 3 -- global statusline

-- ===============================================================
-- # Language specific configuration.
-- ===============================================================
api.nvim_command("au FileType make set noexpandtab shiftwidth=8 softtabstop=0") -- Makefiles must use tabs
api.nvim_command("au FileType yaml setl  sw=2 sts=2")

-- ===============================================================
-- # Built-in debugger
-- ===============================================================
vim.cmd "packadd termdebug" -- Add termdebug
g.termdebugger   = "rust-gdb" -- Set debugger to rust-gdb
g.termdebug_wide = 1 -- Set debugger to use wide terminal

-- ===============================================================
-- # Plugin configuration
-- ===============================================================

-- Vim-indent-guides
g.indent_guides_guide_size            = 1 -- Size of indent
g.indent_guides_start_level           = 2 -- Starts showing from second level
g.indent_guides_enable_on_vim_startup = 1 -- Enable indent guides on startup

-- Github copilot
g.completion_enable_auto_popup    = 1 -- Auto popup
g.completion_matching_ingore_case = 1 -- While in popup ignore caps.
g.copilot_no_tab_map              = 1 -- Don't use <Tab> but <C-J> to accept the suggestion.
g.copilot_node_command            = "~/.nvm/versions/node/v17.9.1/bin/node"
api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Rust fmt
g.rustfmt_autosave       = 1
g.rustfmt_emit_files     = 1
g.rustfmt_failt_silently = 0
g.rust_clip_command      = "xclip -selection clipboard"

-- Vimtex (\ll to start compilation)
g.tex_flavor                   = "latex"
g.vimtex_view_method           = "zathura" -- Use zathura to view compiled pdfs
g.vimtex_complete_close_braces = 1
g.vimsyn_embed                 = 0 -- allows u to select what, if any, types of embedded script highlighting they wish to have.

-- Beacon
g.beacon_minimal_jump = 5 -- Only show beacon if the cursor jumps more than 5 lines.
g.beacon_size         = 40 -- Size of the beacon
