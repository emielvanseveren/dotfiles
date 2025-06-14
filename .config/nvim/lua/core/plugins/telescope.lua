local builtin_telescope = require("telescope.builtin")
local Util = require("core.utils")

return {
  "nvim-telescope/telescope.nvim",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    -- search
    { "<leader>fg", Util.live_grep_from_project_git_root,  desc = "Files [G]rep" },
    { "<leader>ff", Util.find_files_from_project_git_root, desc = "[f]ind [f]iles (repo)" },
    { "<leader>lb", builtin_telescope.buffers,             desc = "[l]ist [b]uffers",        { sort_mru = true, ignore_current_buffer = true } },
    { "<leader>ld", builtin_telescope.diagnostics,         desc = "[l]ist all [d]iagnostics" },
  },
  opts = {
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

        -- TODO: why are these not with vim.set?
        n = {
          -- normal mode
          -- Follows same flow as search result hopping
          ["<C-n>"] = function(...)
            require("telescope.actions").move_selection_worse(...)
          end,
          ["<C-p>"] = function(...)
            require("telescope.actions").move_selection_better(...)
          end,
          ["<Esc>"] = function(...)
            require("telescope.actions").close(...)
          end,
        },
        i = {
          -- insertion mode
          ["<C-n>"] = function(...)
            require("telescope.actions").move_selection_worse(...)
          end,
          ["<C-p>"] = function(...)
            require("telescope.actions").move_selection_better(...)
          end,
          ["<Esc>"] = function(...)
            require("telescope.actions").close(...)
          end,
        },
      },
    },
  },
}
