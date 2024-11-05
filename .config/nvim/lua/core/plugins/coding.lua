return {
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
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

  {
    "folke/lazydev.nvim",
    ft = "lua",
  },

  {
    "slint-ui/vim-slint",
    ft = "slint"
  },

  {
    "mfussenegger/nvim-ansible",
    ft = "yaml",
  },

  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
}
