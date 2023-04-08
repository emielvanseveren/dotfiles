return {
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        diagnostics = {
          enable = true,
        },
        update_cwd = true,
        view = {
          adaptive_size = true,
        },
        git = {
          enable = true,
        },
        filters = {
          dotfiles = true,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "[t]oggle file explorer treeview." })
      vim.keymap.set("n", "<leader><leader>f", "<cmd>NvimTreeFindFile<CR>", { desc = "Move cursor in tree to [f]ile of current buffer." })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        signcolumn = true, -- show signs in column
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        linehl = false,
        numhl = false, -- highlight line number
        word_diff = false, -- highlight word diffs
        attach_to_untracked = true,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
      })
      vim.keymap.set("n", "gj", gitsigns.next_hunk, { desc = "Next git hunk" })
      vim.keymap.set("n", "gk", gitsigns.prev_hunk, { desc = "Previous git hunk" })
      vim.keymap.set("n", "gl", gitsigns.blame_line, { desc = "View git blame" })
      vim.keymap.set("n", "gp", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
    end,
  },

  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    config = function()
      require("aerial").setup()
      vim.keymap.set("n", "<leader><leader>a", "<cmd>AerialToggle<CR>")
    end,
  },

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-telescope/telescope-ui-select.nvim", "xiyaowong/telescope-emoji.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      -- First search in git repo, if not in repo, search from curr_dir
      local project_files = function()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
          builtin.git_files({ show_untracked = true })
        else
          builtin.find_files()
        end
      end

      -- Note: This does not include stuff like .env files since they are not tracked by git.
      vim.keymap.set("n", "ff", project_files, { desc = "Find files, if in git repo, all files in repo, otherwise cwd." })
      vim.keymap.set("n", "fs", builtin.lsp_document_symbols, { desc = "List AST symbols in current buffer." })
      vim.keymap.set("n", "ld", builtin.diagnostics, { desc = "List all diagnostics" })
      vim.keymap.set("n", "lb", builtin.buffers, { desc = "List all buffers" })
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
            n = {
              -- normal mode
              -- Follows same flow as search result hopping
              ["<C-n>"] = actions.move_selection_worse,
              ["<C-p>"] = actions.move_selection_better,
              ["<Esc>"] = actions.close,
              ["fg"] = builtin.livegrep,
              ["fh"] = builtin.help_tags,
              ["fb"] = builtin.buffers,
            },
            i = {
              -- insertion mode
              ["<C-n>"] = actions.move_selection_worse,
              ["<C-p>"] = actions.move_selection_better,
              ["<Esc>"] = actions.close,
            },
          },
        },
        extensions_list = { "emoji", "terms", "ui-select", "neoclip", "harpoon" },
      }

      require("telescope").setup(options)

      -- load extensions
      pcall(function()
        for _, ext in ipairs(options.extensions_list) do
          require("telescope").load_extension(ext)
        end
      end)
    end,
  },
}
