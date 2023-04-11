local map = vim.keymap.set
local Util = require("lazyvim.util")

map("n", "<leader>Y", ":%y+ <CR>", { desc = "Yank entire file" })
map("n", "<Esc>", "<cmd> nohlsearch <CR>", { desc = "Remove search highlight" })
map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<F1>", "<NOP>") -- I can type :help on my own, thanks :)

-- Move lines up and down
map("n", "<leader><leader>j", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<leader><leader>k", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<leader><leader>j", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<leader><leader>k", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<leader><leader>j", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<leader><leader>k", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- I don't like joining two lines
map("n", "J", "<nop>")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Disable arrow keys, break the bad habbit.
map("n", "<Up>", "<NOP>")
map("n", "<Down>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "[NAV] Go to the window on the left." })
map("n", "<C-l>", "<C-w><C-l>", { desc = "[NAV] Go to the window on the right." })
map("n", "<C-j>", "<C-w><C-j>", { desc = "[NAV] Go to the window below." })
map("n", "<C-k>", "<C-w><C-k>", { desc = "[NAV] Go to the window above." })
map("n", "<leader>h", "<C-w>s", { desc = "[NAV] Split window horizontally." })
map("n", "<leader>v", "<C-w>v", { desc = "[NAV] Split window vertically." })
map("n", "<leader>cw", "<C-W>c", { desc = "[WINDOW] Close window." })

-- Navigate within insertion mode.
map("i", "<C-h>", "<Left>", { desc = "[NAV] Go to the left." })
map("i", "<C-l>", "<Right>", { desc = "[NAV] Go to the right." })
map("i", "<C-j>", "<Down>", { desc = "[NAV] Go down." })
map("i", "<C-k>", "<Up>", { desc = "[NAV] Go up." })

-- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- floating terminal
map("n", "<leader>ft", function()
  Util.float_term(nil, { cwd = Util.get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
  Util.float_term()
end, { desc = "Terminal (cwd)" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- lazygit
map("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, { cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  Util.float_term({ "lazygit" })
end, { desc = "Lazygit (cwd)" })

-- Move normally by line.
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
