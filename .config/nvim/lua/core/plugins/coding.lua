return {

  { "nathom/filetype.nvim" },
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  { "andweeb/presence.nvim", event = "VeryLazy" },
  {
    { "lervag/vimtex", event = "VeryLazy" },
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  { "github/copilot.vim" },

  -- git
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        integrations = {
          diffview = true,
        },
      })
      vim.keymap.set("n", "<leader>g", neogit.open)
    end,
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
}
