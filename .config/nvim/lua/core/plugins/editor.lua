local builtin_telescope = require("telescope.builtin")
local Util = require("core.utils")

return {
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    keys = {
      { "<leader><leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Move cursor in tree to [f]ile of current buffer." },
      { "<leader><leader>t", "<cmd>NvimTreeToggle<CR>",   desc = "[t]oggle file explorer treeview." },
    },
    opts = {
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
        dotfiles = false,
        custom = {'^.git$'}
      },
      update_focused_file = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
{
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
      {
        "<leader><leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "[H]arpoon File",
      },
      {
        "<leader><leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "[h]arpoon Quick Menu",
      },
    }
},

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "A", },
        change = { text = "C", },
        delete = { text = "D", },
        topdelete = { text = "TD"},
        changedelete = { text = "CD"},
      },
      signs_staged = {
        add = { text = "SA" },
        change = { text = "SC"},
        delete = { text = "SD", },
        topdelete = { text = "STD"},
        changedelete = { text = "SCD"},
      },
      signs_staged_enable = true,
      signcolumn = true, -- show signs in column
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      linehl = true,
      numhl = true,     -- highlight line number
      word_diff = true , -- highlight words or letters that changed in changed line.
      attach_to_untracked = true,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "ghj", gs.next_hunk, "Next git hunk")
        map("n", "ghk", gs.prev_hunk, "Previous git hunk")
        map("n", "ghp", gs.preview_hunk, "Preview Git hunk")
        map("n", "ghs", gs.stage_hunk, "Preview Git hunk")
        map("n", "ghr", gs.reset_hunk, "Preview Git hunk")
        map("n", "ghS", gs.undo_stage_hunk, "Preview Git hunk")
      end,
    },
  },

  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader><leader>a", "<cmd>AerialToggle<CR>" },
    },
    config = function()
      require("aerial").setup()
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "BufReadPre",
    dependencies = {
      "SmiteshP/nvim-navic",
      "kyazdani42/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>bt",
        function()
          require("barbecue.ui").toggle()
        end,
        desc = "Toggle Barbecue",
      },
    },
    opts = {
      kinds = {
        File = "",
        Module = "",
        Namespace = "",
        Package = "",
        Class = "",
        Method = "m",
        Property = "",
        Field = "",
        Constructor = "",
        Enum = "",
        Interface = "",
        Function = "󰊕",
        Variable = "",
        Constant = "",
        String = "",
        Number = "",
        Boolean = "",
        Array = "",
        Object = "",
        Key = "󰌋",
        Null = "",
        EnumMember = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },
    },
  },
  {
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
      { "<leader>fg", Util.live_grep_from_project_git_root, desc = "Files [G]rep" },
      { "<leader>ff", Util.find_files_from_project_git_root, desc = "[f]ind [f]iles (repo)" },
      -- list
      { "<leader>lb", builtin_telescope.buffers, desc = "[l]ist all [b]uffers" },
      { "<leader>ld", builtin_telescope.diagnostics, desc = "[l]ist all [d]iagnostics" },
      { "<leader>qf", builtin_telescope.quickfix, desc = "Toggle [q]uick [f]ix"},
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
  },
}
