local opt = vim.opt
local g = vim.g

opt.autowrite = true          -- auto write after commands like :next and :previous
opt.shell = "/usr/bin/zsh"    -- Sets default shell to zsh
opt.compatible = false        -- don't try to be like vi.
opt.completeopt = "menuone,noinsert,noselect"
opt.cmdheight = 1             -- Height of command line
opt.updatetime = 750          -- milliseconds nothing is typed the swap file will be written to disk
opt.termguicolors = true      -- Enable termguicolors
opt.background = "dark"       -- Try to use dark colors
opt.clipboard = "unnamedplus" -- Always copy everything to the system clipboard
opt.number = true             -- show line numbers
opt.relativenumber = true     -- Show the line number relative to the line with the cursor
opt.linebreak = true          -- Break lines when max is reached
opt.mouse = "a"               -- Enable the mouse in all modes
opt.scrolloff = 5             -- Keep 5 lines below and above the cursor
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.joinspaces = false        -- Combine >1 consecutive spaces

opt.wrap = false              -- No line wrapping
opt.conceallevel = 0
opt.showmode = false          -- Don't show mode, we have a statusline for that
opt.autochdir = true          -- Vim will change the current working dir whenever you open a file / switch buffers
opt.ruler = true              -- Show the line and column number of the cursor position
opt.spelllang = { "en" }
opt.tabstop = 2               -- Number of spaces that a <TAB> in the file counts for
opt.shiftwidth = 2            -- Tab shift
opt.softtabstop = 2           -- 2 space tab
opt.expandtab = true          -- Use spaces for tabs
opt.ignorecase = true         -- ignore case when searching
opt.splitbelow = true         -- Put new windows below current
opt.splitright = true         -- Put new windows right of current
opt.swapfile = false          -- Disable swap files
opt.laststatus = 3            -- global statusline
opt.undolevels = 10000        -- maximum number of changes that can be undone.
opt.backspace = "2"           -- Backspace over newlines
opt.foldenable = true         -- Disable folding by default
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.vim.treesitter.foldtext()"
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.cursorline = true              -- highlight current line
opt.list = true
opt.listchars = "nbsp:¬,eol:¶,extends:»,precedes:«,trail:•,tab:»·"
opt.splitkeep = "screen"
opt.shortmess:append({ C = true })
opt.smoothscroll = true
opt.smartcase = true -- Don't ignore case with capitals
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.grepprg = "rg --vimgrep"


opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = "⸱",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Colorscheme
vim.cmd([[colorscheme tokyonight]])

-- ===============================================================
-- # Built-in debugger
-- ===============================================================
vim.cmd("packadd termdebug")         -- Add termdebug
g.termdebugger = "rust-gdb"          -- Set debugger to rust-gdb
g.termdebug_wide = 1                 -- Set debugger to use wide terminal
g.editorconfig = true                -- Enable editorconfig
g.tex_flavor = "latex"
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings


vim.lsp.inlay_hint.enable(true) -- Enable inlay hints by default
