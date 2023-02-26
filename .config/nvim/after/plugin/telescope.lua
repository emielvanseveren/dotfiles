local present, telescope = pcall(require, "telescope")

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

if not present then
  return
end

local M = {}

-- First search in git repo, if not in repo, search from curr_dir
M.project_files = function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    builtin.git_files()
  else
    builtin.find_files()
  end
end

-- Note: This does not include stuff like .env files since they are not tracked by git.
vim.keymap.set("n", "ff", M.project_files, { desc = "Find files, if in git repo, all files in repo, otherwise cwd." })
vim.keymap.set("n", "fs", builtin.lsp_document_symbols, { desc = "List AST symbols in current buffer." })
vim.keymap.set("n", "ld", builtin.diagnostics, { desc = "List all diagnostics" })

vim.keymap.set("n", "fg", builtin.live_grep, { desc = "search words" })

vim.keymap.set("n", "fG", function()
  builtin.live_grep({
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  })
end, { desc = "Search words in all files" })

local options = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    file_ignore_patterns = { "node_modules" },
    path_display = { "truncate" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      n = { -- normal mode
        -- Follows same flow as search result hopping
        ["<C-n>"] = actions.move_selection_worse,
        ["<C-p>"] = actions.move_selection_better,
        ["<Esc>"] = actions.close,
        ["fg"] = builtin.livegrep,
        ["fh"] = builtin.help_tags,
        ["fb"] = builtin.buffers,
      },
      i = { -- insertion mode
        ["<C-n>"] = actions.move_selection_worse,
        ["<C-p>"] = actions.move_selection_better,
        ["<Esc>"] = actions.close,
      },
    },
  },
  extensions_list = { "emoji", "terms", "ui-select", "neoclip", "harpoon" },
}

telescope.setup(options)

-- load extensions
pcall(function()
  for _, ext in ipairs(options.extensions_list) do
    telescope.load_extension(ext)
  end
end)

return M
