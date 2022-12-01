local keymap = vim.keymap
local neogit = require("neogit")
local builtin = require("telescope.builtin")

-- # Mappings
-- ======================================== Show a short highlight flash on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

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
keymap.set("n", "<leader>n", "<cmd> bn<CR>", { desc = "Go to next buffer." })
keymap.set("n", "<leader>p", "<cmd> bp<CR>", { desc = "Go to previous buffer." })
keymap.set("n", "<leader>cb", ":bd<CR>:bp<CR>", { desc = "Close buffer (safe)." })

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
keymap.set(
	"n",
	"ff",
	"<CMD>lua require'../plugins/config/telescope'.project_files()<CR>",
	{ desc = "Find files in the current directory" }
)

keymap.set("n", "fg", builtin.live_grep, { desc = "Grep in files in the current directory" })
keymap.set("n", "fh", builtin.help_tags, { desc = "Show list of nvim keywords that link to help files" })
keymap.set("n", "fb", builtin.buffers, { desc = "List buffers" })

-- Neoclip
keymap.set(
	"n",
	"<leader>yy",
	"<cmd>Telescope neoclip unnamedplus extra=unnamedplus<CR>",
	{ desc = "Open the neoclip dashboard" }
)

-- nvim tree
keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer treeview." })

-- Harpoon
keymap.set("n", "<leader>ma", "<cmd>lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "<leader>ml", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

-- neogit
keymap.set("n", "<leader>g", neogit.open)

-- Aerial
keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")

-- Hop (vim motion)
keymap.set(
	"n",
	"fq",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
