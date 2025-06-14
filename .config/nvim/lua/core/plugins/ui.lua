return {
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          always_divide_middle = true,
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },   -- vim mode
          lualine_b = { "branch" }, -- git branch
          lualine_c = {
            {
              "filename",
              path = 3
            }
          },
        },
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    opts = {}
  },
}
