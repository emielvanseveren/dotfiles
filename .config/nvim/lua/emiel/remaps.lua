local keymap = vim.keymap

keymap.set("n", "<leader>Y", ":%y+ <CR>", { desc = "Yank entire file" })
keymap.set("n", "<Esc>", "<cmd> nohlsearch <CR>", { desc = "Remove search highlight" })
keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
keymap.set("n", "<F1>", "<NOP>") -- I can type :help on my own, thanks :)

-- Move lines up and down
keymap.set("v", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("v", "<A-k>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<A-k>", ":m '<Esc>:m .-2<CR>==gi")
keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("n", "<A-k>", ":m '<Esc>:m .-2<CR>==gi")

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
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "[NAV] Go to the window on the left." })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "[NAV] Go to the window on the right." })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "[NAV] Go to the window below." })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "[NAV] Go to the window above." })
keymap.set("n", "<leader>h", "<C-w>s", { desc = "[NAV] Split window horizontally." })
keymap.set("n", "<leader>v", "<C-w>v", { desc = "[NAV] Split window vertically." })

-- Navigate within insertion mode.
keymap.set("i", "<C-h>", "<Left>", { desc = "[NAV] Go to the left." })
keymap.set("i", "<C-l>", "<Right>", { desc = "[NAV] Go to the right." })
keymap.set("i", "<C-j>", "<Down>", { desc = "[NAV] Go down." })
keymap.set("i", "<C-k>", "<Up>", { desc = "[NAV] Go up." })

-- Navigate buffers (bufferline)
keymap.set("n", "<leader>n", "<cmd>BufferLineCycleNext<CR>", { desc = "[BUFFER] next buffer tab." })
keymap.set("n", "<leader>n", "<cmd>BufferLineCyclePrev<CR>", { desc = "[BUFFER] previous buffer tab." })
keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "[BUFFER] next buffer." })
keymap.set("n", "<leader>p", "<cmd>bprevious<CR>", { desc = "[BUFFER] previous buffer." })

-- Mind the capital B, Bdelete is from a separate plugin, it does not delete the window
keymap.set("n", "<leader>c", ":Bdelete<CR>:bp<CR>", { desc = "[BUFFER] Close buffer (safe)." })

-- Move normally by line.
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
