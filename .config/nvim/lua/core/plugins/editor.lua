local Util = require("core.utils")

return {
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    keys = {
      { "<leader><leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Move cursor in tree to [f]ile of current buffer." },
      { "<leader>t",         "<cmd>NvimTreeFocus<CR>",    desc = "[F]ocus file explorer. Useful when multiple windows are open" },
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
  keys = function()
    local keys = {
      {
        "<leader><leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader><leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
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
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      -- search
      { "fg", Util.telescope("live_grep"),              desc = "Find in Files (Grep)" },
      { "ff", Util.telescope("files"),                  desc = "Find Files (root dir)" },
      { "fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      -- list
      { "tb", "<cmd>Telescope buffers<cr>",             desc = "List all buffers" },
      { "td", "<cmd>Telescope diagnostics<cr>",         desc = "List all diagnostics" },
      {
        "ts",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "List Symbol",
      },
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
