return {
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  { "andweeb/presence.nvim", event = "VeryLazy" },
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_method = "zathura"
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
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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
    "github/copilot.vim",
    lazy = "vimEnter",
    init = function()
      -- Github copilot
      vim.g.completion_enable_auto_popup = 1 -- Auto popup
      vim.g.copilot_no_tab_map = 1 -- Don't use <Tab> but <C-J> to accept the suggestion. Tab is already used for cmp.
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.g.completion_matching_ingore_case = 1 -- While in popup ignore caps.
    end,
  },

  {
    "fatih/vim-go",
    build = ":GoInstallBinaries",
  },

  -- git
  {
    "TimUntersberger/neogit",
    keys = {
      {
        "<leader>g",
        function()
          require("neogit").open()
        end,
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },

  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
}
