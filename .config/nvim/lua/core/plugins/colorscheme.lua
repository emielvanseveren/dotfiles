return {
  { "folke/tokyonight.nvim", enabled = false, lazy = false, opts = { style = "night" }, priority = 1000 },

  { "rose-pine/neovim", name = "rose-pine", enabled = true, lazy = false },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    enabled = false,
    priority = 1000
  },

  {
    "catppuccin/nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
