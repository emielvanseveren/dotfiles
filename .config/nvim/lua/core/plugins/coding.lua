return {
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  { "andweeb/presence.nvim", event = "VeryLazy" },
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_method = "zathura_simple" -- basic version of wayland support
      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    lazy = true,
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<C-Y>"
        }
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        yaml = true,
        gitcommit = true,
        help = true,
      }
    }
  },

  { "folke/neodev.nvim", opts = {} },
  {
    "fatih/vim-go",
    lazy = true,
    ft = "go",
    build = ":GoInstallBinaries",
  },

  {
    "slint-ui/vim-slint",
    ft = "slint"
  },
  {
    "mfussenegger/nvim-ansible",
    ft = "yaml",
  },

  -- git
  {
    "neogitorg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      disable_commit_confirmation = true,
      use_telescope = true,
      integrations = {
        diffview = true,
      },
    },
    cmd = { "Neogit" },
    keys = { { "<leader>gs", "<cmd>Neogit<CR>", desc = "neogit" } },
  },

  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
}
