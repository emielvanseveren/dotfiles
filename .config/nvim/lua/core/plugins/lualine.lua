return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
	    require "lualine".setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    always_divide_middle = true,
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },

    lualine_x = { "filetype" },
    lualine_y = { "fileformat" },
    lualine_z = { "location" },
  }
  }
    end
  }
