return {
  { "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      {
        "famiu/bufdelete.nvim",
        keys = {
          { "<leader>cb", ":Bdelete<CR>:bp<CR>", desc = "[BUFFER] [c]lose [b]uffer (safe)." },
        },
      },
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant", -- Space between tabs
          enforce_regular_tabs = true, -- Allow to extend tab size when name is longer than tab_size
          show_buffer_close_icons = false, -- Show close icon
          always_show_bufferline = true, -- Only show bufferline when more than 1 tab
          diagnostics = "nvim_lsp", -- Change color of filename when file has an error
          numbers = "none", -- Don't show numbers on tab
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            { filetype = "NvimTree", text = "File explorer", text_align = "left" },
          },
          show_buffer_icons = true,
        },
      })
      -- buffers
      vim.keymap.set("n", "<leader>n", "<cmd>BufferLineCycleNext<CR>", { desc = "[BUFFER] [n]ext buffer tab." })
      vim.keymap.set("n", "<leader>p", "<cmd>BufferLineCyclePrev<CR>", { desc = "[BUFFER] [p]revious buffer tab." })
    end,
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
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_x = { "filetype" },
          lualine_y = { "fileformat" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile"},
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },
}
