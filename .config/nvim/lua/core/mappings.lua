local keymap = vim.keymap

-- modes
-- n = normal
-- i = insert
-- t = terminal

-- # Mappings
-- ========================================
-- Show a short highlight flash on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

keymap.set("n", "<Esc>", "<cmd> nohlsearch <CR>", { desc = "Remove search highlight" })
keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
keymap.set("n", "<F1>", "<NOP>") -- I can type :help on my own, thanks :)

-- Disable arrow keys, break the bad habbit.
keymap.set("n", "<Up>", "<NOP>")
keymap.set("n", "<Down>", "<NOP>")
keymap.set("n", "<Left>", "<NOP>")
keymap.set("n", "<Right>", "<NOP>")

-- Better window navigation.
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Go to the window on the left." })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Go to the window on the right." })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Go to the window below." })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Go to the window above." })
keymap.set("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally." })
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically." })

-- Navigate within insertion mode.
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")

-- Switch between buffers.
keymap.set("n", "<leader>n", ":bn<CR>", { desc = "Go to next buffer." })
keymap.set("n", "<leader>p", ":bp<CR>", { desc = "Go to previous buffer." })
keymap.set("n", "<leader>cb", ":bd<CR>:bp<CR>", { desc = "Close buffer (safe)." })
keymap.set("n", "<TAB>", ":bn<CR>", { desc = "Go to next buffer if it exists." })
keymap.set("n", "ls", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })

-- Move normally by line.
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })



-- ===============================================================
-- # Plugin mappings
-- ===============================================================

-- Telescope
keymap.set("n", "ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in the current directory" })
keymap.set("n", "fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep in files in the current directory" })

-- Neoclip
keymap.set("n", "<leader>yy", "<cmd>Telescope neoclip unnamedplus extra=unnamedplus<CR>",
  { desc = "Open the neoclip dashboard" })

-- nvim tree
keymap.set("n", "<leader>,", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer treeview." })

-- Harpoon
keymap.set("n", "ma", "<cmd>lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "ml", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

-- neogit
keymap.set("n", "<leader>g", "<cmd>lua require('neogit').open()<CR>")

-- Hop (vim motion)
keymap.set('n', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
keymap.set('n', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
keymap.set('n', 't',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  , {})
keymap.set('n', 'T',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  , {})

-- ===============================================================
-- # Autocommands
-- Basically a callback that is executed when a certain event is triggered.
-- ===============================================================

-- Leave paste mode when leaving insert mode
vim.api.nvim_command("autocmd InsertLeave * set nopaste")

-- Help filetype detection
vim.api.nvim_command("autocmd BufRead *.md    set filetype=markdown")
vim.api.nvim_command("autocmd BufRead *.tex   set filetype=tex")
vim.api.nvim_command("autocmd BufRead *.trm   set filetype=c")
vim.api.nvim_command("autocmd BufRead *.plot  set filetype=gnuplot")

-- Automatically close tab when nvim tree is the only thing still open
-- vim.api.nvim_command("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
