local keymap = vim.keymap

-- Show a short highlight flash on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

keymap.set("n", "<Esc>", "<cmd> nohlsearch <CR>", { desc = "Remove search highlight" })
keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
keymap.set("n", "<F1>", "<NOP>") -- I can type :help on my own, thanks :)

-- Move selected lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- keep cursor in place when using J
keymap.set("n", "J", "mzJ`z")

-- don't copy selection to copy register
keymap.set("x", "<leader>p", '"_dP')

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
keymap.set("n", "<leader>n", "<cmd> bn<CR>", { desc = "Go to next buffer." })
keymap.set("n", "<leader>p", "<cmd> bp<CR>", { desc = "Go to previous buffer." })

-- Mind the capital B, Bdelete is from a separate plugin, it does not delete the window
keymap.set("n", "<leader>cb", ":Bdelete<CR>:bp<CR>", { desc = "Close buffer (safe)." })

-- Move normally by line.
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
