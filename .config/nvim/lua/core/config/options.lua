local opt = vim.opt
local g = vim.g

opt.autowrite = true -- auto write after commands like :next and :previous
opt.shell = "/usr/bin/zsh" -- Sets default shell to zsh
opt.compatible = false -- don't try to be like vi.
opt.completeopt = "menuone,noinsert,noselect"
opt.cmdheight = 1 -- Height of command line
opt.updatetime = 750 -- milliseconds nothing is typed the swap file will be written to disk
opt.termguicolors = true -- Enable termguicolors
opt.background = "dark" -- Try to use dark colors
opt.clipboard = "unnamedplus" -- copy to system clipboard on yank
opt.number = true -- show line numbers
opt.relativenumber = true -- Show the line number relative to the line with the cursor
opt.linebreak = true -- Break lines when max is reached
opt.mouse = "a" -- Enable the mouse in all modes
opt.scrolloff = 5 -- Keep 5 lines below and above the cursor
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.joinspaces = false -- Combine >1 consecutive spaces
opt.wrap = false -- No line wrapping
opt.conceallevel = 0
opt.showmode = false -- Don't show mode, we have a statusline for that
opt.autochdir = true -- Vim will change the current working dir whenever you open a file / switch buffers
opt.ruler = true -- Show the line and column number of the curser position
opt.spelllang = { "en" }
opt.tabstop = 2 -- Number of spaces that a <TAB> in the file counts for
opt.shiftwidth = 2 -- Tab shift
opt.softtabstop = 2 -- 2 space tab
opt.expandtab = true -- Use spaces for tabs
opt.ignorecase = true -- ignore case when searching
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.swapfile = false -- Disable swap files
opt.laststatus = 3 -- global statusline
opt.undolevels = 10000 -- maximum number of changes that can be undone.
opt.backspace = "2" -- Backspace over newlines
opt.foldenable = false -- Disable folding by default
opt.cursorline = true -- highlight current line
opt.list = true
opt.listchars = "nbsp:¬,eol:¶,extends:»,precedes:«,trail:•,tab:»·"

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- ===============================================================
-- # Built-in debugger
-- ===============================================================
vim.cmd("packadd termdebug") -- Add termdebug
g.termdebugger = "rust-gdb" -- Set debugger to rust-gdb
g.termdebug_wide = 1 -- Set debugger to use wide terminal

g.tex_flavor = "latex"
g.vimtex_view_method = "zathura"
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

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
